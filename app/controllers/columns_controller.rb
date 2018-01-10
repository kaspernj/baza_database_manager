class ColumnsController < ApplicationController
  load_and_authorize_resource :profile

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
      @table.create_columns([column_hash])
      redirect_to [@profile, @database, @table, :column, id: params[:column][:name]]
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    with_db do
      @column.change(column_hash)
      redirect_to [@profile, @database, @table, :column, id: params[:column][:name]]
    end
  end

  def destroy
    with_db do
      @column.drop
      redirect_to [@profile, @database, @table]
    end
  end

private

  def column_hash
    hash = {
      name: column_params[:name],
      type: column_params[:type],
      default: column_params[:default].presence,
      maxlength: column_params[:maxlength].presence,
      autoincr: column_params[:autoincr] == "1",
      primarykey: column_params[:primarykey] == "1"
    }

    hash[:after] = column_params[:after] if column_params[:after].present?
    hash
  end

  def column_params
    @column_params ||= params.require(:column).permit(:name, :type, :default, :maxlength, :autoincr, :primarykey, :after)
  end
end
