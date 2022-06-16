class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :tags, through: :tag_maps
end
