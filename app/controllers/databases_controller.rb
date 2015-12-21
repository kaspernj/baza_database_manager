class DatabasesController < ApplicationController
  load_and_authorize_resource :profile

  def index
  end

  def show
    @profile.with_db do |db|
      @database = db.database(params[:id])

      render
    end
  end
end
