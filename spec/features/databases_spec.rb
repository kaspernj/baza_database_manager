# frozen_string_literal: true
require "rails_helper"

describe DatabasesController do
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
    expect(page).to have_http_status(:success)

    # Should redirect because SQLite3 doesn't support multiple databases
    expect(current_path).to eq profile_database_path(profile, db)
  end

  it "#show" do
    visit profile_database_path(profile, db)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_path(profile, db)
  end

  it "#new" do
    visit new_profile_database_path(profile)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq new_profile_database_path(profile)
  end

  it "#create" do
  end

  it "#edit" do
    visit edit_profile_database_path(profile, db)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq edit_profile_database_path(profile, db)
  end

  it "#update" do
  end

  it "#destroy" do
  end
end
