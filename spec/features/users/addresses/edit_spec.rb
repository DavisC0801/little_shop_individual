require "rails_helper"

RSpec.describe "As a registed user" do
  describe 'when I visit my profile page', type: :feature do
    before :each do
      @user = create(:user)
      @address = create(:address, user: @user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'allows the user to go to an edit address form' do
      visit profile_path

      click_button("Edit Address")

      expect(current_path).to eq(edit_profile_address_path(@address.id))
    end

    it "allows the user to edit an address" do
      visit edit_profile_address_path(@address.id)

      fill_in :address_nickname, with: "nickname12345"
      fill_in :address_street, with: "address12345"
      fill_in :address_city, with: "city12345"
      fill_in :address_state, with: "state12345"
      fill_in :address_zip, with: "98765"

      click_button "Submit"

      expect(current_path).to eq(profile_path)

      within("#address-#{@address.id}-info") do
        expect(page).to have_content("nickname12345")
        expect(page).to have_content("address12345")
        expect(page).to have_content("city12345")
        expect(page).to have_content("state12345")
        expect(page).to have_content("98765")
      end
    end

    context "create shipped order" do
      before :each do
        @order = create(:order, user: @user, address: @address, status: 2)
      end
      it "will not edit itself if used in an order" do
        visit profile_path

        expect(current_path).to eq(profile_path)
        expect(page).to_not have_button("Delete Address")
      end
    end
  end
end
