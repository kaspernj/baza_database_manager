# frozen_string_literal: true
require "rails_helper"

describe DashboardsController do
  let(:user) { create :user }

  before do
    login_as user
  end

  it "#index" do
    visit dashboards_path
    expect(page).to have_http_status(:success)

    expect(current_path).to eq profiles_path
    # expect(current_path).to eq dashboards_path
  end
end
