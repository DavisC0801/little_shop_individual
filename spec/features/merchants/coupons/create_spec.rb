require "rails_helper"

RSpec.describe "As a merchant" do
  describe 'when I visit my profile page', type: :feature do
    before :each do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    end

    it 'allows the user to go to an add coupon form' do
      visit dashboard_coupons_path

      click_button("Add New Coupon")

      expect(current_path).to eq(new_dashboard_coupon_path)
    end

    it "allows the user to add a new coupon" do
      visit new_dashboard_coupon_path

      fill_in :coupon_name, with: "name12345"
      fill_in :coupon_value, with: "123.45"
      page.choose "Dollar"

      click_button "Submit"

      expect(current_path).to eq(dashboard_coupons_path)

      expect(page).to have_content("name12345")
      expect(page).to have_content("123.45")
      expect(page).to have_content("Percentage")
      expect(page).to have_content("Active: true")
    end
  end
end
