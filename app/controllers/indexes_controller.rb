# frozen_string_literal: true
class IndexesController < ApplicationController
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
      @table.create_indexes([
                              {
                                name: params[:index][:name],
                                columns: column_names_array
                              }
                            ])

      redirect_to profile_database_table_index_path(@profile, @database.name, @table.name, params[:index][:name])
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    with_db do
      @index.drop
      @table.create_indexes([
                              {
                                name: params[:index][:name],
                                columns: column_names_array
                              }
                            ])

      redirect_to profile_database_table_index_path(@profile, @database.name, @table.name, params[:index][:name])
    end
  end

  def destroy
    with_db do
      @index.drop
      redirect_to [@profile, @database, @table]
    end
  end

private

  def column_names_array
    column_names = []
    params[:columns].each_value do |column_name|
      next unless column_name.present?
      column_names << column_name
    end

    column_names
  end
end
