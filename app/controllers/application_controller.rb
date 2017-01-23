class ApplicationController < ActionController::Base
  include AwesomeTranslations::ControllerTranslateFunctionality

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, with: :can_can_access_denied

private

  def with_db
    args = {debug: false}
    args[:db] = params[:database_id] if params[:database_id]

    @profile.with_db(args) do |db|
      @db = db

      set_db_instance_variables
      set_object_by_params_id

      yield
    end
  end

  def set_db_instance_variables
    set_database_from_param
    set_table_from_param
    set_column_from_param
    set_foreign_key_from_param
    set_index_from_param
    set_row_from_param
  end

  def set_database_from_param
    @database = @db.databases[params[:database_id]] if params[:database_id]
  end

  def set_table_from_param
    @table = @database.table(params[:table_id]) if params[:table_id]
  end

  def set_column_from_param
    @column = @table.column(params[:column_id]) if params[:column_id]
  end

  def set_foreign_key_from_param
    @foreign_key = @table.foreign_key(params[:foreign_key_id]) if params[:foreign_key_id]
  end

  def set_index_from_param
    @index = @table.index(params[:index_id]) if params[:index_id]
  end

  def set_row_from_param
    @row = @table.row(params[:row_id]) if params[:row_id]
  end

  def set_object_by_params_id
    return unless params[:id]

    set_database_from_controller
    set_table_from_controller
    set_column_from_controller
    set_foreign_key_from_controller
    set_index_from_controller
    set_row_from_controller
  end

  def set_database_from_controller
    @database = @db.databases[params[:id]] if controller_name == "databases"
  end

  def set_table_from_controller
    @table = @database.table(params[:id]) if controller_name == "tables"
  end

  def set_column_from_controller
    @column = @table.column(params[:id]) if controller_name == "columns"
  end

  def set_foreign_key_from_controller
    @foreign_key = @table.foreign_key(params[:id]) if controller_name == "foreign_keys"
  end

  def set_index_from_controller
    @index = @table.index(params[:id]) if controller_name == "indexes"
  end

  def set_row_from_controller
    @row = @table.row(params[:id]) if controller_name == "rows"
  end

  def can_can_access_denied
    if signed_in?
      flash[:error] = controller_t(".you_dont_have_access_to_that_page")
      redirect_to :back
    else
      flash[:notice] = controller_t(".please_sign_in_first")
      session[:user_return_to] = request.original_url
      redirect_to new_user_session_url
    end
  end
end
