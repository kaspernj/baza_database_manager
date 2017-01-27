class SqlExecutionsController < ApplicationController
  load_and_authorize_resource :profile

  before_action :set_values

  def new
    with_db do
      render
    end
  end

  def create
    with_db do
      @query = @db.query(@values[:sql])

      render
    end
  end

private

  def set_values
    @values = params[:sql_execution] || {}
  end
end
