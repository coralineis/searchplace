class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :like
  belongs_to :review
end
