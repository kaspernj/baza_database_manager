require "rails_helper"

describe IndexesController do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:index) { table.index("name") }
  let(:db) { db_inst.database("Main") }

  before do
    login_as user
  end

  it "#show" do
    visit profile_database_table_index_path(profile, db.name, table.name, index.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_index_path(profile, db.name, table.name, index.name)
  end

  it "#new" do
    visit new_profile_database_table_index_path(profile, db.name, table.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq new_profile_database_table_index_path(profile, db.name, table.name)
  end

  it "#create" do
    visit new_profile_database_table_index_path(profile, db.name, table.name)

    fill_in "Name", with: "new_index"
    find("select#columns_column_name_0").select("id")
    find("select#columns_column_name_1").select("name")

    find("form.index input[type=submit]").click

    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_index_path(profile, db.name, table.name, "new_index")
  end

  it "#edit" do
    visit edit_profile_database_table_index_path(profile, db.name, table.name, index.name)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq edit_profile_database_table_index_path(profile, db.name, table.name, index.name)
  end

  it "#update" do
    visit edit_profile_database_table_index_path(profile, db.name, table.name, index.name)

    fill_in "Name", with: "new_name_index"
    find("form.index input[type=submit]").click

    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_index_path(profile, db.name, table.name, "new_name_index")
  end

  it "#destroy" do
    visit profile_database_table_index_path(profile, db.name, table.name, index.name)
    find(".delete-index").click

    expect { index.reload }.to raise_error(Baza::Errors::IndexNotFound)
    expect(current_path).to eq profile_database_table_path(profile, db.name, table.name)
  end
end
