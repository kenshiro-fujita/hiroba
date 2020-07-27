class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :release_date, presence: true
  validate :release_date_cannot_future
  validates :isbn, presence: true, uniqueness: true,
                   format: { with: /\A\d{13}\z|\A\d{10}\z/ } # 10桁または13桁数値

  has_many :reviews
  has_many :recommendations
  has_many :recommender, through: :recommendations, source: :user

  def release_date_cannot_future
    errors.add(:release_date, '未来の日付は選択できません') if release_date.present? && release_date.future?
  end
end
