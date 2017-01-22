# frozen_string_literal: true
require "rails_helper"

describe TablesController do
  let!(:user) { create :user }
  let!(:profile) { create :profile }
  let(:db_inst) { profile.database_instance }
  let(:table) { db_inst.tables["test_table"] }
  let(:db) { db_inst.databases["Main"] }

  before do
    login_as user
  end

  it "#show" do
    visit profile_database_table_path(profile, db, table)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq profile_database_table_path(profile, db, table)
  end

  it "#new" do
    visit new_profile_database_table_path(profile, db)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq new_profile_database_table_path(profile, db)
  end

  it "#create" do
    visit new_profile_database_table_path(profile, db)

    find("#table_name").set("new_table")
    find("#columns_column_0_name").set("id")
    find("#columns_column_0_type").select("int")
    find("form.table input[type=submit]").click

    expect(current_path).to eq profile_database_table_path(profile, db, "new_table")
  end

  it "#edit" do
    visit edit_profile_database_table_path(profile, db, table)
    expect(page).to have_http_status(:success)
    expect(current_path).to eq edit_profile_database_table_path(profile, db, table)

    expect(find("#table_name").value).to eq "test_table"
    expect(find("#columns_column_0_name").value).to eq "id"
    expect(find("#columns_column_0_type").value).to eq "int"
  end

  it "#update" do
    visit edit_profile_database_table_path(profile, db, table)
    find("#table_name").set("new_name")
    find("#columns_column_0_name").set("new_id")
    find("form.table input[type=submit]").click

    new_table = db_inst.tables["new_name"]
    expect(new_table.name).to eq "new_name"

    new_column = new_table.column("new_id")
    expect(new_column.name).to eq "new_id"

    expect(current_path).to eq profile_database_table_path(profile, db, "new_name")
  end

  it "#destroy" do
    visit profile_database_table_path(profile, db, table)
    find(".pull-right a.btn-danger").click
    expect { table.reload }.to raise_error(Baza::Errors::TableNotFound)
  end
end
