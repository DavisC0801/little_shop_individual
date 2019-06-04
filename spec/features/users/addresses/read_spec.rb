require "rails_helper"

RSpec.describe "As a registed user" do
  describe "when I have no addresses" do
    before :each do
      @user = create(:user)
      item_1 = create(:item)
      visit item_path(item_1)
      click_on "Add to Cart"
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it "will not allow user to check out" do
      visit cart_path

      expect(page).to have_content("You must have at least one address to check out.")
    end
  end

  describe 'when I visit my profile page', type: :feature do
    before :each do
      @user = create(:user)
      @address_1 = create(:address, user: @user)
      @address_2 = create(:address, user: @user)
      @address_3 = create(:address, user: @user)
      @address_4 = create(:address, user: @user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'allows the user to view all addresses' do
      visit profile_path

      expect(current_path).to eq(profile_path)

      within("#address-#{@address_1.id}-info") do
        expect(page).to have_content(@address_1.nickname)
        expect(page).to have_content(@address_1.street)
        expect(page).to have_content(@address_1.city)
        expect(page).to have_content(@address_1.state)
        expect(page).to have_content(@address_1.zip)
      end
      within("#address-#{@address_2.id}-info") do
        expect(page).to have_content(@address_2.nickname)
        expect(page).to have_content(@address_2.street)
        expect(page).to have_content(@address_2.city)
        expect(page).to have_content(@address_2.state)
        expect(page).to have_content(@address_2.zip)
      end
      within("#address-#{@address_3.id}-info") do
        expect(page).to have_content(@address_3.nickname)
        expect(page).to have_content(@address_3.street)
        expect(page).to have_content(@address_3.city)
        expect(page).to have_content(@address_3.state)
        expect(page).to have_content(@address_3.zip)
      end
      within("#address-#{@address_4.id}-info") do
        expect(page).to have_content(@address_4.nickname)
        expect(page).to have_content(@address_4.street)
        expect(page).to have_content(@address_4.city)
        expect(page).to have_content(@address_4.state)
        expect(page).to have_content(@address_4.zip)
      end
    end
  end
end
