class ShopGenre < ApplicationRecord
  has_many :shops, dependent: :destroy
end
