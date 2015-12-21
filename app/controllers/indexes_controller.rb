class IndexesController < ApplicationController
  load_and_authorize_resource :profile

  def show
    @profile.with_db do |db|
      @db = db
      set_database_table_and_index
    end
  end

private

  def set_database_table_and_index
    @database = @db.database(params[:database_id])
    @table = @database.table(params[:table_id])
    @index = @table.index(params[:id])
  end
end
