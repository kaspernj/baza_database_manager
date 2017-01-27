require "rails_helper"

describe ImportsController do
  let(:db) { db_inst.databases["Main"] }
  let(:db_inst) { profile.database_instance }
  let(:profile) { create :profile }
  let(:user) { create :user }
  let(:table) { db_inst.tables["test_table"] }

  describe "#new" do
    it "renders the page" do
      login_as user

      visit new_profile_database_path(profile, db)

      expect(page).to have_http_status :success
      expect(current_path).to eq new_profile_database_path(profile, db)
    end
  end

  describe "#create" do
    it "imports the given sql file" do
      login_as user

      visit new_profile_database_import_path(profile, db)

      attach_file "File", Rails.root.join("spec", "test_files", "test.sql")

      find("input[type=submit]").click

      expect(page).to have_http_status :success
      expect(current_path).to eq profile_database_path(profile, db)
    end
  end
end
