require "rails_helper"

describe ExportsController do
  let(:export) { create :export, profile: profile }
  let(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.databases["Main"] }

  describe "#show" do
    it "renders the page" do
      login_as user

      visit profile_database_export_path(profile, db, export)

      expect(page).to have_http_status :success
      expect(current_path).to eq profile_database_export_path(profile, db, export)
    end

    it "exports sql" do
      login_as user

      visit profile_database_export_path(profile, db, export, format: :sql)

      expect(page).to have_http_status :success
      expect(current_path).to eq profile_database_export_path(profile, db, export, format: :sql)
      expect(page.response_headers["Content-Disposition"]).to eq "attachment; filename=\"Main.sql.gz\""
    end
  end

  describe "#new" do
    it "renders the page" do
      login_as user

      visit new_profile_database_export_path(profile, db)

      expect(page).to have_http_status :success
      expect(current_path).to eq new_profile_database_export_path(profile, db)
    end
  end

  describe "#create" do
    it "creates a new export" do
      login_as user

      visit new_profile_database_export_path(profile, db)

      expect { find("input[type=submit]").click }.to change(Export, :count).by(1)

      created_export = Export.last

      expect(page).to have_http_status :success
      expect(current_path).to eq profile_database_export_path(profile, db, created_export)
    end
  end

  describe "#edit" do
    it "renders the page" do
      login_as user

      visit edit_profile_database_export_path(profile, db, export)

      expect(page).to have_http_status :success
      expect(current_path).to eq edit_profile_database_export_path(profile, db, export)
    end
  end

  describe "#update" do
    it "updates the given export" do
      login_as user

      visit edit_profile_database_export_path(profile, db, export)

      find("input[type=submit]").click

      expect(page).to have_http_status :success
      expect(current_path).to eq profile_database_export_path(profile, db, export)
    end
  end

  describe "#destroy" do
    it "deletes the export" do
      login_as user

      visit profile_database_export_path(profile, db, export)

      expect do
        find(".btn-danger").click
      end.to change(Export, :count).by(-1)

      expect(page).to have_http_status :success
      expect(current_path).to eq profile_database_path(profile, db)
    end
  end
end
