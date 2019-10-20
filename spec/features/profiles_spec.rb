require "rails_helper"

describe "profiles" do
  let(:user) { create :user }
  let(:profile) { create :profile }

  context "when logged in" do
    before do
      login_as user
    end

    it "#index" do
      visit profiles_path
      expect(page).to have_http_status(:success)
      expect(page).to have_current_path profiles_path, ignore_query: true
    end

    it "#show" do
      visit profile_path(profile)
      expect(page).to have_http_status(:success)
      expect(page).to have_current_path profile_path(profile), ignore_query: true
    end

    it "#new" do
      visit new_profile_path
      expect(page).to have_http_status(:success)
      expect(page).to have_current_path new_profile_path, ignore_query: true
    end

    it "#create" do
      visit new_profile_path(profile)

      fill_in Profile.human_attribute_name(:name), with: "Test create profile"
      select "Mysql2", from: Profile.human_attribute_name(:database_type)

      expect do
        click_on "Create Profile"
        expect(flash_messages).to eq nil
      end.to change(Profile, :count).by(1)
    end

    it "#edit" do
      visit edit_profile_path(profile)
      expect(page).to have_http_status(:success)
      expect(page).to have_current_path edit_profile_path(profile), ignore_query: true
    end

    it "#update" do
      visit edit_profile_path(profile)

      fill_in Profile.human_attribute_name(:name), with: "Test update profile"
      click_on "Update Profile"

      expect(profile.reload.name).to eq "Test update profile"
    end

    it "#destroy" do
      profile
      visit profiles_path

      expect { find(".delete-profile-#{profile.id}").click }.to change(Profile, :count).by(-1)
    end
  end

  it "redirects to sign in if access is denied" do
    visit profile_path(profile)
    expect(page).to have_http_status(:success)
    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end
end
