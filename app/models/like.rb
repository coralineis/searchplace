class Like < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :place

  validates_uniqueness_of :plan_id, scope: :user_id
  validates_uniqueness_of :place_id, scope: :user_id
end
