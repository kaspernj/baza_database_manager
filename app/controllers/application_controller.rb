class ApplicationController < ActionController::Base
  include AwesomeTranslations::ControllerTranslateFunctionality

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def with_db
    args = {debug: true}
    args[:db] = params[:database_id] if params[:database_id]

    @profile.with_db(args) do |db|
      @db = db

      @database = @db.databases[params[:database_id]] if params[:database_id]
      @table = @database.table(params[:table_id]) if params[:table_id]
      @column = @table.column(params[:column_id]) if params[:column_id]
      @index = @table.index(params[:index_id]) if params[:index_id]
      @row = @table.row(params[:row_id]) if params[:row_id]

      set_object_by_params_id

      yield
    end
  end

  def set_object_by_params_id
    return unless params[:id]

    if controller_name == "databases"
      @database = @db.databases[params[:id]]
    elsif controller_name == "tables"
      @table = @database.table(params[:id])
    elsif controller_name == "columns"
      @column = @table.column(params[:id])
    elsif controller_name == "indexes"
      @index = @table.index(params[:id])
    elsif controller_name == "rows"
      @row = @table.row(params[:id])
    end
  end
end
