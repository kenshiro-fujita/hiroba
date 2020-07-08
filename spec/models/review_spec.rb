require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
  @user = FactoryBot.create(:user)
  @book = FactoryBot.create(:book)
  end
  
  describe '適切な条件のため有効' do
    it "適切な条件のため有効" do
      review = Review.new(
      user_id: @user.id,
      book_id: @book.id,
      rev_title: "sample_rev_title",
      content: "sample review content.",
      )
      expect(review).to be_valid
    end
  end

  describe 'user/book関連' do
    let(:params) { { rev_title: 'test_rev_title', content: 'testing_review_content' } }
    let(:review) { Review.new(params) }
    context '紐づかない投稿' do
      it 'userと紐づかないため無効' do
        params.merge!(book_id: @book.id)
        review = Review.new(params)
        expect(review).to be_invalid
      end
      it 'userと紐づかないため無効' do
        params.merge!(book_id: @book.id)
        review = Review.new(params)
        expect(review).to be_invalid
      end
    end
    context 'userの二重投稿' do
      it '二重投稿のため無効' do
        params.merge!(book_id: @book.id, user_id: @user.id)
        review1 = Review.new(params)
        review1.save
        review2 = Review.new(params)
        expect(review2).to be_invalid
      end
    end
  end

  describe 'rev_title・contentの文字数' do
    let(:params) { { user_id: @user.id, book_id: @book.id } }
    let(:review) { Review.new(params) }
    context 'rev_titleの文字数' do
      it '50文字以上のため無効' do
        params.merge!(rev_title: 'test_review_title'*10, content: 'sample review content.')
        review = Review.new(params)
        expect(review).to be_invalid
      end
    end
    context 'contentの文字数' do
      it '20文字未満のため無効' do
        params.merge!(rev_title: 'test_review_title', content: 'test content.')
        review = Review.new(params)
        expect(review).to be_invalid
      end
      it '1万字以上のため無効' do
        params.merge!(rev_title: 'test_review_title', content: 'test review content over 10,000 characters. '*300)
        review = Review.new(params)
        expect(review).to be_invalid
      end
    end
  end

end

# reviewの投稿失敗パターン
# user/book/rev_title/contentのいずれかがnil
# userが二重投稿しようとした
# rev_titleが50文字を超える
# contentが20文字未満または１万字以上
