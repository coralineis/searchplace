class Plan < ApplicationRecord
  mount_uploaders :images, ImageUploader
  acts_as_taggable

  belongs_to :user
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
