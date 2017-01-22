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

      @database = @db.databases[params[:database_id]] if params[:database_id]
      @table = @database.table(params[:table_id]) if params[:table_id]
      @column = @table.column(params[:column_id]) if params[:column_id]
      @foreign_key = @table.foreign_key(params[:foreign_key_id]) if params[:foreign_key_id]
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
    elsif controller_name == "foreign_keys"
      @foreign_key = @table.foreign_key(params[:id])
    elsif controller_name == "indexes"
      @index = @table.index(params[:id])
    elsif controller_name == "rows"
      @row = @table.row(params[:id])
    end
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
