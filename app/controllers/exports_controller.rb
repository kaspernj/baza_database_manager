class ExportsController < ApplicationController
  load_and_authorize_resource :profile
  load_and_authorize_resource :export, through: :profile

  def new
    with_db do
      render
    end
  end

  def create
    with_db do
      if @export.save
        redirect_to [@profile, @db, @export]
      else
        flash[:error] = @export.errors.full_messages.join(". ")
      end
    end
  end
end
