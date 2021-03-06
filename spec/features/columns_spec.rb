require "rails_helper"

describe "columns" do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:column) { table.column(:id) }
  let(:db) { db_inst.databases["Main"] }

  before do
    login_as user
  end

  it "#show" do
    visit profile_database_table_column_path(profile, db, table, column)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path profile_database_table_column_path(profile, db, table, column), ignore_query: true
  end

  it "#new" do
    visit new_profile_database_table_column_path(profile, db, table)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path new_profile_database_table_column_path(profile, db, table), ignore_query: true
  end

  it "#create" do
    visit new_profile_database_table_column_path(profile, db, table)

    fill_in "Name", with: "new_column"
    select "Varchar", from: "Type"
    find("form.column input[type=submit]").click

    new_column = table.column("new_column")
    expect(new_column.name).to eq "new_column"
    expect(new_column.type).to eq :varchar

    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path profile_database_table_column_path(profile, db, table, new_column), ignore_query: true
  end

  it "#edit" do
    visit edit_profile_database_table_column_path(profile, db, table, column)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path edit_profile_database_table_column_path(profile, db, table, column), ignore_query: true
  end

  it "#update" do
    visit edit_profile_database_table_column_path(profile, db, table, column)

    fill_in "Name", with: "new_id"
    find("form.column input[type=submit]").click

    changed_column = table.column("new_id")
    expect(changed_column.name).to eq "new_id"

    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path profile_database_table_column_path(profile, db, table, changed_column), ignore_query: true
  end

  it "#destroy" do
    visit profile_database_table_column_path(profile, db, table, column)
    find(".delete-column-btn").click
    expect { column.reload }.to raise_error(Baza::Errors::ColumnNotFound)
  end
end
