# frozen_string_literal: true
class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Redirect until a dashboard have actually been made
    redirect_to profiles_path
  end
end
