class DatabasesController < ApplicationController
  load_and_authorize_resource :profile

  def index
    with_db do
      @databases = @profile.databases.to_a

      redirect_to [@profile, @databases.first] if !@db.supports_multiple_databases? && @databases.length == 1
    end
  rescue => e
    flash[:error] = "#{e.class.name}: #{e.message}"
    redirect_to @profile
  end

  def show
    with_db do
      render
    end
  end

  def new
    with_db do
      render
    end
  end

  def create
    with_db do
      @db.databases.create(database_params)
      database = @db.databases[database_params[:name]]
      redirect_to [@profile, database]
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    with_db do
      @database.rename(params[:database][:name]) unless params[:database][:name] == @database.name
      redirect_to [@profile, @database]
    end
  end

  def destroy
  end

private

  def database_params
    params.require(:database).permit(:name)
  end
end
