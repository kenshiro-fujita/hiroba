class User < ApplicationRecord
  
before_save { self.email.downcase! }
validates :name, presence: true, length:{ maximum: 50}
validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
validates :password, presence: true,
                  format: { with: /\A(?=.*?[a-z])(?=.*?\d)[\w]{8,40}\z/} 
                        #8~40の半角全角英数字を使用可能。数字と英字の混合

  has_secure_password
  
  has_many :reviews
  has_many :books
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow #自分がフォローしているユーザー一覧を取得
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user #自分をフォローしているユーザー一覧を取得
  
  def follow(other_user)
    unless self == other_user
    self.relationship.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
end
