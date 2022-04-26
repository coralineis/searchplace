class Shop < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :like
  belongs_to :shop_genre
end
