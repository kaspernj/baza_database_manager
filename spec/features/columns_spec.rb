require "rails_helper"

describe ColumnsController do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:column) { table.column(:id) }
  let(:db) { db_inst.database("Main") }

  before do
    login_as user
  end

  it "#show" do
    visit profile_database_table_column_path(profile, db.name, table.name, column.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_column_path(profile, db.name, table.name, column.name)
  end

  it "#new" do
    visit new_profile_database_table_column_path(profile, db.name, table.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq new_profile_database_table_column_path(profile, db.name, table.name)
  end

  it "#create" do
    visit new_profile_database_table_column_path(profile, db.name, table.name)

    fill_in "Name", with: "new_column"
    select "Varchar", from: "Type"
    find("form.column input[type=submit]").click

    new_column = table.column("new_column")
    expect(new_column.name).to eq "new_column"
    expect(new_column.type).to eq :varchar

    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_column_path(profile, db.name, table.name, new_column.name)
  end

  it "#edit" do
    visit edit_profile_database_table_column_path(profile, db.name, table.name, column.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq edit_profile_database_table_column_path(profile, db.name, table.name, column.name)
  end

  it "#update" do
    visit edit_profile_database_table_column_path(profile, db.name, table.name, column.name)

    fill_in "Name", with: "new_id"
    find("form.column input[type=submit]").click

    changed_column = table.column("new_id")
    expect(changed_column.name).to eq "new_id"

    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_column_path(profile, db.name, table.name, changed_column.name)
  end

  it "#destroy" do
    visit profile_database_table_column_path(profile, db.name, table.name, column.name)
    find(".delete-column-btn").click
    expect { column.reload }.to raise_error(Baza::Errors::ColumnNotFound)
  end
end
