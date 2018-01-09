class ForeignKeysController < ApplicationController
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
      begin
        local_column.create_foreign_key(
          name: foreign_key_params[:name],
          column: column
        )

        flash[:success] = controller_t(".the_foreign_key_was_created")
        redirect_to [@profile, @database, @table]
      rescue Baza::Errors::TableNotFound
        flash[:error] = controller_t(".no_such_table", table_name: foreign_key_params[:table_name])
        render :new
      rescue Baza::Errors::ColumnNotFound
        flash[:error] = controller_t(".no_such_column", column_name: foreign_key_params[:column_name])
        render :new
      end
    end
  end

  def edit; end

  def update
    raise "stub"
  end

  def destroy
    with_db do
      @foreign_key.drop
      redirect_to [@profile, @database, @table]
    end
  end

private

  def foreign_key_params
    params.require(:foreign_key).permit(:name, :local_column_name, :table_name, :column_name)
  end

  def local_column
    @table.column(foreign_key_params[:local_column_name])
  end

  def table
    @db.tables[foreign_key_params[:table_name]]
  end

  def column
    table.column(foreign_key_params[:column_name])
  end
end
