class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates_presence_of :nickname, :street, :city, :state, :zip

  def used?
    completed_order_count = orders.where("orders.status = 1 or orders.status = 2").count
    completed_order_count > 0
  end
end
