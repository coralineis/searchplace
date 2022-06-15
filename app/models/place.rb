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

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Like.group(:place_id).order(Arel.sql('count(place_id) desc')).pluck(:place_id))
    end
  end
end
