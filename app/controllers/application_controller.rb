class ApplicationController < ActionController::Base
  include AwesomeTranslations::ControllerTranslateFunctionality

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def with_db
    @profile.with_db do |db|
      @db = db

      @database = @db.database(params[:database_id]) if params[:database_id]
      @table = @database.table(params[:table_id]) if params[:table_id]
      @column = @table.column(params[:column_id]) if params[:column_id]
      @index = @table.index(params[:index_id]) if params[:index_id]

      set_object_by_params_id

      yield
    end
  end

  def set_object_by_params_id
    return unless params[:id]

    if controller_name == "tables"
      @table = @database.table(params[:id])
    elsif controller_name == "columns"
      @column = @table.column(params[:id])
    elsif controller_name == "indexes"
      @index = @table.index(params[:id])
    end
  end
end
