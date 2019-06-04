require "rails_helper"

RSpec.describe "As a registed user" do
  describe 'when I visit my profile page', type: :feature do
    before :each do
      @user = create(:user)
      @address = create(:address, user: @user)
    end

    it 'allows the user to go delete an address' do
      login_as(@user)
      visit profile_path

      click_button("Delete Address")

      @user.reload

      expect(current_path).to eq(profile_path)

      expect(page).to_not have_content(@address.street)
      expect(page).to_not have_content(@address.city)
      expect(page).to_not have_content(@address.state)
      expect(page).to_not have_content(@address.zip)
    end

    context "create shipped order" do
      before :each do
        @order = create(:order, user: @user, address: @address, status: 2)
      end
      it "will not delete itself if used in an order" do
        login_as(@user)
        visit profile_path

        expect(current_path).to eq(profile_path)
        expect(page).to_not have_button("Delete Address")
      end
    end
  end
end
