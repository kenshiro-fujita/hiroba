require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'association' do
    describe 'belongs_to' do
      it "適切な条件のため有効" do
        review = Review.new(
        user_id: 1,
        book_id: 1,
        rev_title: "sample_review_title",
        content: "asdfoirjogianriogerijforjgiao",
        )
        expect(review).to be_valid
      end
    end
  end
end