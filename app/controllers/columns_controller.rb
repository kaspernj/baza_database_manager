class ColumnsController < ApplicationController
  load_and_authorize_resource :profile

  def show
    @profile.with_db do |db|
      @db = db
      set_database_table_and_column
      render
    end
  end

private

  def set_database_table_and_column
    @database = @db.database(params[:database_id])
    @table = @database.table(params[:table_id])
    @column = @table.column(params[:id])
  end
end
