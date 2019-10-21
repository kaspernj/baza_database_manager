require "rails_helper"

describe "databases" do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.databases["Main"] }

  before do
    login_as user
  end

  it "#index" do
    visit profile_databases_path(profile)
    expect(page).to have_http_status(:ok)

    # Should redirect because SQLite3 doesn't support multiple databases
    expect(page).to have_current_path profile_database_path(profile, db), ignore_query: true
  end

  it "#show" do
    visit profile_database_path(profile, db)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path profile_database_path(profile, db), ignore_query: true
  end

  it "#new" do
    visit new_profile_database_path(profile)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path new_profile_database_path(profile), ignore_query: true
  end

  it "#edit" do
    visit edit_profile_database_path(profile, db)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path edit_profile_database_path(profile, db), ignore_query: true
  end
end
