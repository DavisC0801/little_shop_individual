require "rails_helper"

RSpec.describe "As a merchant" do
  describe 'when I visit the coupon page', type: :feature do
    before :each do
      @user = create(:user, role: 1)
      address = create(:address, user: @user)
      @coupon = create(:coupon, user: @user)
    end

    it 'allows the user to go delete an address' do
      login_as(@user)
      visit dashboard_coupons_path

      click_button("Delete Coupon")

      @user.reload

      expect(current_path).to eq(dashboard_coupons_path)

      expect(page).to_not have_content(@coupon.value)
      expect(page).to_not have_content(@coupon.coupon_type)
      expect(page).to_not have_content(@coupon.active)
    end
  end
end
