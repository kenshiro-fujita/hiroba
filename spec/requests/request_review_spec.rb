require 'rails_helper'
describe ReviewsController, type: :request do

  describe 'GET #show' do
    before do
      # @user = FactoryBot.create(:user)
      # allow_any_instance_of(ActionDispatch::Request)
      # .to receive(:session).and_return(user_id: @user.id)
      # @book = FactoryBot.create(:infection)
    end
    context 'reviewが存在する' do
      before do
        @review = FactoryBot.create(:infection_rev)
      end
      it '画面遷移する' do
        get book_review_path(@review.book_id, @review.id)
        expect(response.status).to eq 200
      end
      it '適切なreviewが呼び出される' do
        get book_review_path(@review.book_id, @review.id)
        expect(response.body).to include 'リスクコミュニケーション'
      end
    end
    context 'reviewが存在しない' do
      subject { -> { get user_url 100 } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
  describe 'POST #create' do
    context '適切な条件' do
      before do
        @user = FactoryBot.create(:user)
        allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: @user.id)
        @book = FactoryBot.create(:infection)
      end
      it 'リクエストに成功する' do
        post "/books/#{@book.id}/reviews", params: { review: FactoryBot.attributes_for(:infection_rev) }
        expect(response.status).to eq 302
      end
      it '書評が投稿される' do
        expect do
          post "/books/#{@book.id}/reviews", params: { review: FactoryBot.attributes_for(:infection_rev) }
        end.to change(Review, :count).from(0).to(1)
      end
      it '書評ページにリダイレクトされる' do
        post "/books/#{@book.id}/reviews", params: { review: FactoryBot.attributes_for(:infection_rev) }
        expect(response).to redirect_to book_review_path(book_id: @book.id, id: Review.last.id)
      end
    end
    context '不適切な入力値' do
      before do
        @user = FactoryBot.create(:kimika)
        allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: @user.id)
        @book = FactoryBot.create(:infection)
      end
      it 'リクエストには成功する' do
        post "/books/#{@book.id}/reviews", params: { review: FactoryBot.attributes_for(:fail_infection_rev) }
        expect(response.status).to eq 302
      end
      it 'reviewが投稿されない。' do
        expect do
          post "/books/#{@book.id}/reviews", params: { review: FactoryBot.attributes_for(:fail_infection_rev) }
        end.to_not change(Review, :count)
      end
    end
    # context 'ログインせずに投稿' do
    #   it 'ログインユーザーのみ投稿可能なため失敗' do
    #     @user = FactoryBot.create(:user)
    #     @book = FactoryBot.create(:infection)
    #     pending #エラーは起きてくれるが、意図通りではない
    #     expect do
    #       post "/books/#{@book.id}/reviews", params: { review: FactoryBot.attributes_for(:infection_rev) }
    #     end.not_to change(Review, :count)
    #   end
    # end
  end
  
  # describe 'GET #edit' do
  # review.createすると作れるが、そのreviewのuser_idを持ったuserを作る方法がわからない。
  # 調べて再度実装。今の方法(before内部は@reviewの行のみ実行)だと@userはid2、@reviewのuser_idは1になる。
  # あとログインしてないとcreateできなかった気がするが、素直にできた。それも謎。
  # before内部で@userと@bookを作成した場合、@user.idが1、@reviewのuser_idが2になる。単純に作った順番になってる。
  # @userが@bookに対してreviewを投稿」をテストコードで再現する方法がわかる必要がある。
  #   context 'ログインユーザーが自身の書評を編集' do
  #     before 'ユーザーをログイン状態にしてreviewを準備' do
  #       @user = FactoryBot.create(:kimika)
  #       allow_any_instance_of(ActionDispatch::Request)
  #       .to receive(:session).and_return(user_id: @user.id)
  #       @book = FactoryBot.create(:infection)
  #       @review = FactoryBot.create(:infection_rev)
  #     end
  #     it 'リクエストに成功する' do
  #       # @user = FactoryBot.create(:kimika)
  #       byebug
  #       # allow_any_instance_of(ActionDispatch::Request)
  #       # .to receive(:session).and_return(user_id: @user.id)
  #       get edit_book_review_path(book_id: @review.book_id, id: @review.id)
  #       expect(response.status).to eq 302
  #     end
  #     it '元のrev_titleが表示される' do
  #       get edit_book_review_url(book_id: @review.book_id, id: @review.id)
  #       byebug
  #       expect(response.body).to include '感染症パニック'
  #     end
  #     it '元のcontentが表示される' do
  #     end
  #   end
  # end
  # describe 'PATCH #update' do
  # end
  # describe 'DELETE #destroy' do
  # end
end