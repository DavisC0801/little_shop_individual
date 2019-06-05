class Coupon < ApplicationRecord
  enum coupon_type: [:Dollar, :Percentage]

  validates_presence_of :value, :coupon_type
  validates :name, presence: true, uniqueness: true

  belongs_to :user

  def used?
    completed_order_count = user.items.joins(:orders).where("orders.status = 1 or orders.status = 2").count
    completed_order_count > 0
  end

  def self.max_limit?
    self.count >= 5
  end
end
