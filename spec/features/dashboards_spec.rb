require "rails_helper"

describe "dashboards" do
  let(:user) { create :user }

  before do
    login_as user
  end

  it "#index" do
    visit dashboards_path
    expect(page).to have_http_status(:ok)

    expect(page).to have_current_path profiles_path, ignore_query: true
    # expect(current_path).to eq dashboards_path
  end
end
