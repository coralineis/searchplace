class Plan < ApplicationRecord
  attachment :image
  acts_as_taggable

  belongs_to :user
  belongs_to :review
  has_many :likes, dependent: :destroy
end
