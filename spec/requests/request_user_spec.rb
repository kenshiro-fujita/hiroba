require 'rails_helper'

describe UsersController, type: :request do
  describe 'GET #show' do
    let(:kimika) { FactoryBot.create :kimika }
    context 'userが存在する' do
      it '画面遷移に成功する' do
        get user_url kimika.id
        expect(response.status).to eq 200
      end
      it '適切なuserが呼び出された' do
        get user_url kimika.id
        expect(response.body).to include 'kimika'
      end
    end
    context 'userが存在しない' do
      subject { -> { get user_url 100 } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
  
  describe 'GET #new' do
    it 'リクエストが成功する' do
      get signup_url
      expect(response.status).to eq 200
    end
  end
  
  describe 'POST #create' do
    context '適切な条件' do
      it 'リクエストに成功する。' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end
      it 'ユーザー登録される' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).from(0).to(1)
      end
      it 'ユーザーページにリダイレクトされる' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end
    
    context '不適切な条件' do
      it 'リクエストには成功する' do
        post users_url, params: { user: FactoryBot.attributes_for(:fail_himura) }
        expect(response.status).to eq 200
      end
      it 'ユーザーが登録されない' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:fail_himura) }
        end.to_not change(User, :count)
      end
      it 'エラーメッセージが表示される' do
        post users_url, params: { user: FactoryBot.attributes_for(:fail_himura) }
        expect(response.body).to include 'ユーザー登録に失敗しました'
      end
      # it '新規登録ページが再表示される' do
      #   post users_url, params: { user: FactoryBot.attributes_for(:fail_himura) }
      #   expect(response).to reder signup_url
      # end
      # renderメソッドは未定義だってことでエラーになる。redirectじゃなくrenderしてるかを確認する時はどうするか調べる
    end
  end

  describe 'GET #edit' do
    let(:himura) { FactoryBot.create :himura }
    context 'ログインユーザーが自分自身を編集' do
    before 'ログイン状態にする' do
      allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session).and_return(user_id: himura.id)
    end
      it 'リクエストが成功' do
        get edit_user_url himura
        expect(response.status).to eq 200
      end
      it '自身のユーザー名が表示される' do
        get edit_user_url himura
        expect(response.body).to include 'himura'
      end
      it '自身のアドレスが表示される' do
        get edit_user_url himura
        expect(response.body).to include 'himura@himura.com'
      end
    end
    context '別userの編集画面にアクセス' do
      let(:kimika) { FactoryBot.create :kimika }
      let(:himura) { FactoryBot.create :himura }
      before 'ログイン状態にする' do
        allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: himura.id)
      end
        it 'トップページにリダイレクトされる' do
          get edit_user_url kimika.id
          expect(response).to redirect_to root_url
        end
    end
    # 未ログインuserがアクセスしようとしたときにredirectされることは明示的に検証できてはいない。
    # unless user.id == current_user.id でエラーが起きるため代替的に検証できてはいるだろうが、このエラーをうまく表現する方法がわからないので保留。
  end
  
  describe 'PATCH #update' do
    let(:himura) { FactoryBot.create :himura }
    before 'ログイン状態にする' do
      allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session).and_return(user_id: himura.id)
    end
    context '適切な条件' do
      it 'リクエストに成功する' do
        patch user_path himura, params: { user: FactoryBot.attributes_for(:kimika) }
        expect(response.status).to eq 302
      end
      it 'ユーザー名が置き換わる' do
        expect do
          patch user_url himura, params: { user: FactoryBot.attributes_for(:kimika) }
        end.to change { User.find(himura.id).name }.from('himura').to('kimika')
      end
      it 'ユーザーページにリダイレクトする' do
        patch user_url himura, params: { user: FactoryBot.attributes_for(:kimika) }
        expect(response).to redirect_to User.last
      end
      # it 'フラッシュメッセージが表示される' do
      #   patch user_url himura, params: { user: FactoryBot.attributes_for(:kimika) }
      #   expect(response.body).to include 'ユーザー情報を更新しました'
      # end
      # リダイレクトされた後にuser#showでメッセージが表示されるので表現がわからないため保留。
    end
    context '不適切な条件' do
      it 'リクエストには成功する' do
        patch user_url himura, params: { user: FactoryBot.attributes_for(:fail_himura) }
        expect(response.status).to eq 200
      end
      it 'ユーザー情報が編集されない' do
        expect do
          patch user_url himura, params: { user: FactoryBot.attributes_for(:fail_himura) }
        end.to_not change(User.find(himura.id), :name)
      end
      it 'エラーが表示される' do
        patch user_url himura, params: { user: FactoryBot.attributes_for(:fail_himura) }
        expect(response.body).to include 'ユーザー情報の更新に失敗しました'
      end
      # it 'editページにリダイレクトされる' do
      # end
      # post#createと同じ理由で保留
    end
  end
end