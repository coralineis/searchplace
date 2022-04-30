class Plan < ApplicationRecord
  attachment :image

  belongs_to :user
  belongs_to :like
  belongs_to :review
end
