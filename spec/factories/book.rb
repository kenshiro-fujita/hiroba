FactoryBot.define do
  factory :book do
    isbn { rand(1_000_000_000...9_999_999_999).to_s }
    title { 'test_book_title_factory' }
    author { 'test_author_factory' }
    publisher { 'test_publisher_factory' }
    release_date { Date.today }
  end

  factory :free, class: Book do
    isbn { 4_488_006_515 }
    title { '自由からの逃走' }
    author { 'エーリッヒ・フロム' }
    publisher { '東京創元社' }
    release_date { Date.new(2018, 12, 22) }
  end

  factory :infection, class: Book do
    isbn { 9_784_334_038_281 }
    title { '感染症パニックを防げ' }
    author { '岩田健太郎' }
    publisher { '光文社新書' }
    release_date { Date.new(2020, 4, 30) }
  end

  factory :fail_infection, class: Book do
    isbn { 9999 }
    title { '感染症パニックを防ぐのは無理だ' }
    author { 'ヤブ医者' }
    publisher { 'ヤブ医者出版会' }
    release_date { Date.new(1999, 1, 1) }
  end
end
