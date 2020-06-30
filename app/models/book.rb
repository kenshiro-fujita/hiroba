class Book < ApplicationRecord

  validates :release_date, presence: true
  validates :isbn, presence: true, uniqueness: true,
            format: { with:/\A\d{13}|\d{10}\z/ } #10桁または13桁

  has_many :reviews
  has_many :recommendations
end
