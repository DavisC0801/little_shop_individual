class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates_presence_of :nickname, :address, :city, :state, :zip
end
