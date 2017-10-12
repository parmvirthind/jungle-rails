class Review < ActiveRecord::Base
  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  validates :rating, presence:true
end

# numericality: { only_integer: true, greater_than: 0, less_than: 6}