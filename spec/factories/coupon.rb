FactoryBot.define do
  factory :coupon, class: Coupon do
    user
    sequence(:name) { |n| "Name #{n}" }
    sequence(:value) { |n| "Value #{n}" }
    sequence(:coupon_type) { "Percentage" }
    sequence(:active) { true }
  end
end
