require "rails_helper"

describe ExportsController do
  let(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.databases["Main"] }

  before do
    login_as user
  end

  it "#new" do
    visit new_profile_database_export_path(profile, db)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq visit new_profile_database_export_path(profile, db)
  end

  it "#create" do
    visit new_profile_database_export_path(profile, db)

    expect { find("input[type=submit]").click }.to change(Export, :count).by(1)

    created_export = Export.last

    expect(page).to have_http_status(:success)
    expect(current_path).to eq visit profile_database_export_path(profile, db, created_export)
  end
end
