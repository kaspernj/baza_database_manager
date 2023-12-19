class TablesController < ApplicationController
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
      @db.tables.create(params[:table][:name], columns: columns)
      redirect_to params[:redirect_to].presence || profile_database_table_path(@profile, @database.name, params[:table][:name])
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    with_db do
      @table.rename(params[:table][:name]) unless params[:table][:name] == @table.name
      columns_data = columns

      count = 0
      @table.columns do |column|
        column_data = columns_data[count]
        column.change(column_data)
        count += 1
      end

      redirect_to params[:redirect_to].presence || [@profile, @database, @table]
    end
  end

  def destroy
    with_db do
      @table.drop
      flash[:notice] = controller_t(".table_was_dropped")
      redirect_to params[:redirect_to].presence || [@profile, @database]
    end
  end

private

  def columns
    columns = []
    params[:columns].each_value do |column_data|
      next if column_data.fetch(:name).blank?

      column = {
        name: column_data.fetch(:name),
        type: column_data.fetch(:type)
      }

      column[:default] = column_data.fetch(:default) if column_data.fetch(:default).present?
      column[:primarykey] = true if column_data.fetch(:primarykey) == "1"
      column[:autoincr] = true if column_data.fetch(:autoincr) == "1"
      column[:maxlength] = column_data.fetch(:maxlength) if column_data.fetch(:maxlength).present?

      columns << column
    end

    columns
  end
end
