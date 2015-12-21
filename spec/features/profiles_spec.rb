require "rails_helper"

describe ProfilesController do
  it "#index" do
    visit profiles_path
    expect(page).to have_http_status(:success)
  end
end
