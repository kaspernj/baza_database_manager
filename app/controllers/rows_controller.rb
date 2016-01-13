class RowsController < ApplicationController
  load_and_authorize_resource :profile

  def index
    with_db do
      @query = @db
        .new_query
        .from(@table.name)
        .limit(30)

      apply_filters

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

private

  ALLOWED_FILTERS = ["=", "!=", ">=", "<=", ">", "<"]
  def apply_filters
    return unless params[:filter]

    params[:filter].each_value do |filter_data|
      column = filter_data.fetch(:column)
      type = filter_data.fetch(:type)
      value = filter_data.fetch(:value)

      next if !column.present? || !type.present? || !value.present?
      next unless ALLOWED_FILTERS.include?(type)

      @query = @query.where("#{@db.sep_table}#{@db.escape_table(@table.name)}#{@db.sep_table}.#{@db.sep_col}#{@db.escape_column(column)}#{@db.sep_col} #{type} ?", value)
    end
  end
end
