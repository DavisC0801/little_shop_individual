require "rails_helper"

RSpec.describe "As a merchant" do
  describe 'when I visit my profile page', type: :feature do
    before :each do
      @user = create(:user, role: 1)
      @coupon = create(:coupon, user: @user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'allows the user to go to an edit address form' do
      visit dashboard_coupons_path

      click_button("Edit Coupon")

      expect(current_path).to eq(edit_dashboard_coupon_path(@coupon.id))
    end

    it "allows the user to edit an address" do
      visit edit_dashboard_coupon_path(@coupon.id)

      fill_in :coupon_name, with: "name12345"
      fill_in :coupon_value, with: "123.45"
      page.choose "Percentage"

      click_button "Submit"

      expect(current_path).to eq(dashboard_coupons_path)

      expect(page).to have_content("name12345")
      expect(page).to have_content("123.45")
      expect(page).to have_content("Percentage")
      expect(page).to have_content("Active: true")
    end
  end
end
