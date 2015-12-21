class TablesController < ApplicationController
  load_and_authorize_resource :profile

  def show
    @profile.with_db do |db|
      @database = db.database(params[:database_id])
      @table = @database.table(params[:id])

      render
    end
  end
end
