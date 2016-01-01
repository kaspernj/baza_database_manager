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
    {
      name: params[:column][:name],
      type: params[:column][:type],
      default: params[:column][:default].present? ? params[:column][:default] : nil,
      maxlength: params[:column][:maxlength].present? ? params[:column][:maxlength] : nil,
      autoincr: params[:column][:autoincr] == "1" ? true : false,
      primarykey: params[:column][:primarykey] == "1" ? true : false
    }
  end
end
