class ForeignKeysController < ApplicationController
  load_and_authorize_resource :profile

  def show
    with_db do
      render
    end
  end

  def new; end

  def create
    raise "stub"
  end

  def edit; end

  def update
    raise "stub"
  end

  def destroy
    raise "stub"
  end
end
