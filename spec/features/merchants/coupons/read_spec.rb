require "rails_helper"

RSpec.describe "As a merchant" do
  describe 'when I visit my profile page', type: :feature do
    before :each do
      @user = create(:user, role: 1)
      @coupon_1 = create(:coupon, user: @user)
      @coupon_2 = create(:coupon, user: @user)
      @coupon_3 = create(:coupon, user: @user)
      @coupon_4 = create(:coupon, user: @user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'allows the user to view all addresses' do
      visit dashboard_coupons_path

      expect(current_path).to eq(dashboard_coupons_path)

      within("#coupon-#{@coupon_1.id}") do
        expect(page).to have_content(@coupon_1.name)
        expect(page).to have_content(@coupon_1.value)
        expect(page).to have_content(@coupon_1.coupon_type)
        expect(page).to have_content(@coupon_1.active)
      end
      within("#coupon-#{@coupon_2.id}") do
        expect(page).to have_content(@coupon_2.name)
        expect(page).to have_content(@coupon_2.value)
        expect(page).to have_content(@coupon_2.coupon_type)
        expect(page).to have_content(@coupon_2.active)
      end
      within("#coupon-#{@coupon_3.id}") do
        expect(page).to have_content(@coupon_3.name)
        expect(page).to have_content(@coupon_3.value)
        expect(page).to have_content(@coupon_3.coupon_type)
        expect(page).to have_content(@coupon_3.active)
      end
      within("#coupon-#{@coupon_4.id}") do
        expect(page).to have_content(@coupon_4.name)
        expect(page).to have_content(@coupon_4.value)
        expect(page).to have_content(@coupon_4.coupon_type)
        expect(page).to have_content(@coupon_4.active)
      end
    end
  end
end
