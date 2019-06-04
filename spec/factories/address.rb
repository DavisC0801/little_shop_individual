FactoryBot.define do
  factory :address, class: Address do
    sequence(:street) { |n| "Street #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip) { |n| "Zip #{n}" }
  end
end
