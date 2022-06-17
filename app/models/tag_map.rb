class TagMap < ApplicationRecord
  belongs_to :place
  belongs_to :tag

  validates :place_id, presence: true
  validates :tag_id, presence: true
end
