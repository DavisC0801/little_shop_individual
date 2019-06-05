require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :value }
    it { should validate_presence_of :coupon_type }
  end

  describe 'relationships' do
    # as merchant
    it { should belong_to :user }
  end

  describe "instance methods" do
    it "#used?" do
      coupon = create(:coupon)
      expect(coupon.used?).to be_falsy
      create(:order, status: 2)
      expect(coupon.used?).to be_truthy
    end
  end

  describe "class methods" do
    it "#max_limit" do
      expect(Coupon.max_limit?).to be_falsy
      c1, c2, c3, c4, c5 = create_list(:coupon, 5)
      expect(Coupon.max_limit?).to be_truthy
    end
  end
end
