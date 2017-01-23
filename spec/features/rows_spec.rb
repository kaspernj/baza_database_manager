require "rails_helper"

describe RowsController do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.databases["Main"] }
  let(:row) do
    table.insert(id: 5, name: "Test")
    table.row(5)
  end

  before do
    login_as user
  end

  it "#index" do
    visit profile_database_table_rows_path(profile, db, table)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_rows_path(profile, db, table)
  end

  it "#show" do
    visit profile_database_table_row_path(profile, db, table, row)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_row_path(profile, db, table, row)
  end

  it "#new" do
    visit new_profile_database_table_row_path(profile, db, table)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq new_profile_database_table_row_path(profile, db, table)
  end

  # it "#create" do
  #   raise "stub"
  # end

  it "#edit" do
    visit edit_profile_database_table_row_path(profile, db, table, row)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq edit_profile_database_table_row_path(profile, db, table, row)
  end

  # it "#destroy" do
  #   raise "stub"
  # end
end
