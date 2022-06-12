class Place < ApplicationRecord
  mount_uploader :image, ImageUploader
  acts_as_taggable
  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  belongs_to :place_genre
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
