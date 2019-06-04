require "rails_helper"

RSpec.describe "As a registed user" do
  describe 'when I visit my profile page', type: :feature do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'allows the user to go to an add address form' do
      visit profile_path

      click_button("Add New Address")

      expect(current_path).to eq(new_profile_address_path)
    end

    it "allows the user to add a new address" do
      visit new_profile_address_path

      fill_in :address_nickname, with: "nickname12345"
      fill_in :address_street, with: "address12345"
      fill_in :address_city, with: "city12345"
      fill_in :address_state, with: "state12345"
      fill_in :address_zip, with: "98765"

      click_button "Submit"

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("nickname12345")
      expect(page).to have_content("address12345")
      expect(page).to have_content("city12345")
      expect(page).to have_content("state12345")
      expect(page).to have_content("98765")
    end
  end
end
