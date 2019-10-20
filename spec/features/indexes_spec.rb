require "rails_helper"

describe "indexes" do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:index) { table.index("name") }
  let(:db) { db_inst.databases["Main"] }

  before do
    login_as user
  end

  it "#show" do
    visit profile_database_table_index_path(profile, db, table, index)
    expect(page).to have_http_status(:success)
    expect(page).to have_current_path profile_database_table_index_path(profile, db, table, index), ignore_query: true
  end

  it "#new" do
    visit new_profile_database_table_index_path(profile, db, table)
    expect(page).to have_http_status(:success)
    expect(page).to have_current_path new_profile_database_table_index_path(profile, db, table), ignore_query: true
  end

  it "#create" do
    visit new_profile_database_table_index_path(profile, db, table)

    fill_in "Name", with: "new_index"
    find("select#columns_column_name_0").select("id")
    find("select#columns_column_name_1").select("name")

    find("form.index input[type=submit]").click

    expect(page).to have_http_status(:success)
    expect(page).to have_current_path profile_database_table_index_path(profile, db, table, "new_index"), ignore_query: true
  end

  it "#edit" do
    visit edit_profile_database_table_index_path(profile, db, table, index)
    expect(page).to have_http_status(:success)
    expect(page).to have_current_path edit_profile_database_table_index_path(profile, db, table, index), ignore_query: true
  end

  it "#update" do
    visit edit_profile_database_table_index_path(profile, db, table, index)

    fill_in "Name", with: "new_name_index"
    find("select#columns_column_name_1").select("id")
    find("form.index input[type=submit]").click

    expect(page).to have_http_status(:success)
    expect(page).to have_current_path profile_database_table_index_path(profile, db, table, "new_name_index"), ignore_query: true

    renamed_index = table.index("new_name_index")
    expect(renamed_index.columns).to eq %w[name id]
  end

  it "#destroy" do
    visit profile_database_table_index_path(profile, db, table, index)
    find(".delete-index").click

    expect { index.reload }.to raise_error(Baza::Errors::IndexNotFound)
    expect(page).to have_current_path profile_database_table_path(profile, db, table), ignore_query: true
  end
end
