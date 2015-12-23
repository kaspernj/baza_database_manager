class DatabasesController < ApplicationController
  load_and_authorize_resource :profile

  def index
    @databases = @profile.databases.to_a

    redirect_to profile_database_path(@profile, @databases.first.name) if @databases.length == 1
  end

  def show
    @profile.with_db do |db|
      @database = db.database(params[:id])

      render
    end
  end
end
