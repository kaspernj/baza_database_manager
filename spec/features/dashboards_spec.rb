require "rails_helper"

describe DashboardsController do
  it "#index" do
    visit dashboards_path
    expect(page).to have_http_status(:success)
    expect(current_path).to eq dashboards_path
  end
end
