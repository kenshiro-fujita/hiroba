FactoryBot.define do
  factory :book do
    isbn { rand(1000000000...9999999999).to_s }
    title {'test_book_title_factory'}
    author {'test_author_factory'}
    publisher { 'test_publisher_factory' }
    release_date { Date.today }
  end
end