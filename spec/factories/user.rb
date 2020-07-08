FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_name#{n}"}
    sequence(:email) { |n| "test_address#{n}@test.com"}
    password { '1234asdf' }
    password_confirmation { '1234asdf' }
  end
end