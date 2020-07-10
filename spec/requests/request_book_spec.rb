require 'rails_helper'

describe BooksController, type: :request do
  describe 'GET #index' do
    before do
      FactoryBot.create :free
      FactoryBot.create :infection
    end
    it 'リクエストに成功する' do
      get books_url
      expect(response.status).to eq 200
    end
    it 'ユーザー名が表示される' do
      get books_url
      expect(response.body).to include '自由からの逃走'
      expect(response.body).to include '感染症パニックを防げ'
    end
  end
  
  describe 'GET #show' do
    let(:infection) { FactoryBot.create :infection }
    context 'bookが存在する' do
      it 'book#showが表示される' do
        get book_url infection.id
        expect(response.status).to eq 200
      end
      it '適切なbookが呼び出される' do
        get book_url infection.id
        expect(response.body).to include '岩田健太郎'
      end
    end
    context 'userが存在しない' do
      subject { -> { get book_url 100 } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
  describe 'GET #new' do
    it 'リクエストに成功する' do
      get new_book_url
      expect(response.status).to eq 200
    end
  end
  
  describe 'POST #create' do
    context '適切な条件' do
      before 'ログイン状態' do
        @user = FactoryBot.create(:user)
        allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: @user.id)
      end
        it 'リクエストに成功する' do
          post books_url, params: { book: FactoryBot.attributes_for(:book) }
          expect(response.status).to eq 302
        end
        it 'bookが登録される' do
          expect do
            post books_url, params: { book: FactoryBot.attributes_for(:free) }
          end.to change(Book, :count).from(0).to(1)
        end
        it '当該bookページにリダイレクトされる' do
          post books_url, params: { book: FactoryBot.attributes_for(:free) }
          expect(response).to redirect_to Book.last
        end
    end
    context '不適切な入力値' do
      before 'ログイン状態' do
        @user = FactoryBot.create(:user)
        allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: @user.id)
      end
      it 'リクエストには成功する' do
        post books_url, params: { book: FactoryBot.attributes_for(:fail_infection) }
        expect(response.status).to eq 200
      end
      it 'bookが登録されない' do
        expect do
          post books_url, params: { book: FactoryBot.attributes_for(:fail_infection) }
        end.to_not change(Book, :count)
      end
      it 'エラーメッセージが表示される' do
        post books_url, params: { book: FactoryBot.attributes_for(:fail_infection) }
        expect(response.body).to include '本の登録に失敗しました'
      end
    end
    context 'ログインせずに登録' do
      it 'ログインユーザーのみ登録可能なため失敗' do
        expect do
        post books_url, params: { book: FactoryBot.attributes_for(:free) }
        end.not_to change(Book, :count)
      end
    end
  end
end