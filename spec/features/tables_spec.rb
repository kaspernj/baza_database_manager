require "rails_helper"

describe TablesController do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.database("Main") }

  before do
    login_as user
  end

  it "#show" do
    visit profile_database_table_path(profile, db.name, table.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_path(profile, db.name, table.name)
  end

  it "#new" do
    visit new_profile_database_table_path(profile, db.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq new_profile_database_table_path(profile, db.name)
  end

  it "#create" do
    visit new_profile_database_table_path(profile, db.name)

    find("#table_name").set("new_table")
    find("#columns_column_0_name").set("id")
    find("#columns_column_0_type").select("int")
    find("form.table input[type=submit]").click

    expect(current_path).to eq profile_database_table_path(profile, db.name, "new_table")
  end

  it "#edit" do
    visit edit_profile_database_table_path(profile, db.name, table.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq edit_profile_database_table_path(profile, db.name, table.name)

    expect(find("#table_name").value).to eq "test_table"
    expect(find("#columns_column_0_name").value).to eq "id"
    expect(find("#columns_column_0_type").value).to eq "int"
  end

  it "#update" do
    visit edit_profile_database_table_path(profile, db.name, table.name)
    find("#table_name").set("new_name")
    find("#columns_column_0_name").set("new_id")
    find("form.table input[type=submit]").click

    new_table = db_inst.tables["new_name"]
    expect(new_table.name).to eq "new_name"

    new_column = new_table.column("new_id")
    expect(new_column.name).to eq "new_id"

    expect(current_path).to eq profile_database_table_path(profile, db.name, "new_name")
  end

  it "#destroy" do
    visit profile_database_path(profile, db.name)
    find(".delete-table-#{table.name}").click
    expect { table.reload }.to raise_error(Baza::Errors::TableNotFound)
  end
end
