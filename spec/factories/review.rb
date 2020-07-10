FactoryBot.define do
  factory :review do
    association :user
    association :book
    rev_title {'test_review_title_factory'}
    content { 'test_review_content_factory' }
  end
  
  factory :infection_rev, class: Review do
    association :user
    association :book
    rev_title {'感染症パニックを防げの書評'}
    content { '正しいリスクコミュニケーション（情報発信）を行うための網羅的解説。' }
  end
  
  factory :fail_infection_rev, class: Review do
    association :user
    association :book
    rev_title {''}
    content { 'fail test review content for infection' }
  end
  
end