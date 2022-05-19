class Place < ApplicationRecord
  attachment :image
  acts_as_taggable

  belongs_to :user
  belongs_to :place_genre
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
