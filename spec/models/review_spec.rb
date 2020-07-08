require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '適切な条件のため有効' do
    it "適切な条件のため有効" do
      review = Review.new(
      user_id: user.id,
      book_id: book.id,
      rev_title: "sample_review_title",
      content: "sample review content.",
      )
      expect(review).to be_valid
    end
  end
end