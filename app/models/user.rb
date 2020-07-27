class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       format: { with: /\A(?=.*?[a-z])(?=.*?\d)[\w]{8,40}\z/ }
  # 8~40の半角全角英数字を使用可能。数字と英字の混合

  has_secure_password

  has_many :reviews
  has_many :books
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow # 自分がフォローしているユーザー一覧を取得
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user # 自分をフォローしているユーザー一覧を取得

  has_many :favorites
  has_many :likes, through: :favorites, source: :review
  # 1行目がuserがお気に入りした書評と一対多、2行目でその書評を取得（user1.likes）
  # likesなる関係は、faroriveテーブル（モデル）のreviewカラムと当該userのペアですよということを追記。

  has_many :recommendations
  has_many :importants, through: :recommendations, source: :book
  # 同じくuser.importantsでおすすめ本の一覧を取得。importantなる関係はrecommendationsのbookカラムとのペア

  # user同士のフォロー関係を中間テーブルを通じて実現するメソッド
  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def my_reviews
    Review.where(user_id: following_ids + [id])
  end

  # userがreviewをお気に入りするための関係を中間テーブルを通じて実現するメソッド
  def great(review)
    favorites.find_or_create_by(review_id: review.id)
  end

  def ungreat(review)
    fav = favorites.find_by(review_id: review.id)
    fav&.destroy
  end

  def greated?(review)
    likes.include?(review)
  end

  def recommend(book)
    recommendations.find_or_create_by(book_id: book.id)
  end

  def unrecommend(book)
    recom = recommendations.find_by(book_id: book.id)
    recom&.destroy
  end

  def recommended?(book)
    importants.include?(book)
  end
end
