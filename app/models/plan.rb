class Plan < ApplicationRecord
  mount_uploader :image, ImageUploader
  acts_as_taggable

  belongs_to :user
  belongs_to :review
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
