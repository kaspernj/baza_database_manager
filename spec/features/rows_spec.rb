require "rails_helper"

describe "rows" do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.databases["Main"] }
  let(:row) do
    table.insert(id: 5, name: "Test") # rubocop:disable Rails/SkipsModelValidations
    table.row(5)
  end

  before do
    login_as user
  end

  it "#index" do
    visit profile_database_table_rows_path(profile, db, table)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path profile_database_table_rows_path(profile, db, table), ignore_query: true
  end

  it "#show" do
    visit profile_database_table_row_path(profile, db, table, row)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path profile_database_table_row_path(profile, db, table, row), ignore_query: true
  end

  it "#new" do
    visit new_profile_database_table_row_path(profile, db, table)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path new_profile_database_table_row_path(profile, db, table), ignore_query: true
  end

  # it "#create" do
  #   raise "stub"
  # end

  it "#edit" do
    visit edit_profile_database_table_row_path(profile, db, table, row)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path edit_profile_database_table_row_path(profile, db, table, row), ignore_query: true
  end

  # it "#destroy" do
  #   raise "stub"
  # end
end
