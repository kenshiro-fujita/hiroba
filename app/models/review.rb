class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book 
    #この二つにより、userとbookに紐づかないとreviewは投稿できない。
    #review側はインスタンスメソッドuserを使える。当該reviewと紐づいたuserを取得。
    #review.user という形で、reviewがオブジェクト・userがメソッド。bookも同様。
    #user側はhas_many : reviewsとしていて、これも同様にuser.reviewsというというメソッドが使える。
    #当該userの前reviewを取得する。
    
  has_many :favorites
  validates :user_id, presence: true, uniqueness: {scope: :book_id  }
  validates :book_id, presence: true
  validates :content, presence: true, 
    length: {minimum: 20, maximum: 100000}
  validates :rev_title, presence: true, length: {maximum: 50}
  
end
