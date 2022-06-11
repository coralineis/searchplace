class Place < ApplicationRecord
  mount_uploader :image, ImageUploader
  acts_as_taggable

  belongs_to :user
  belongs_to :place_genre
  has_many :likes, dependent: :destroy
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
