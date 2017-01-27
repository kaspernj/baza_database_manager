class ImportsController < ApplicationController
  load_and_authorize_resource :profile

  def new
    with_db do
      render
    end
  end

  def create
    with_db do
      @database.import_file! params[:import][:file].path

      flash[:success] = controller_t(".the_file_was_imported")
      redirect_to [@profile, @database]
    end
  end
end
