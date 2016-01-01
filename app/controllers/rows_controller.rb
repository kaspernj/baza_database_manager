class RowsController < ApplicationController
  load_and_authorize_resource :profile

  def index
    with_db do
      render
    end
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
      @table.insert(params[:row])
      redirect_to [@profile, @database, @table, :rows]
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    with_db do
      @row.update(params[:row])
      redirect_to [@profile, @database, @table, :rows]
    end
  end

  def destroy
    with_db do
      @row.delete
      redirect_to [@profile, @database, @table, :rows]
    end
  end
end
