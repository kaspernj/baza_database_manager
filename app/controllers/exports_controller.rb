class ExportsController < ApplicationController
  load_and_authorize_resource :profile
  load_and_authorize_resource :export, through: :profile

  def index
    with_db do
      @ransack = @profile.exports.accessible_by(current_ability).ransack(params[:q])
      @exports = @ransack.result
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
      if @export.save
        redirect_to [@profile, @db, @export]
      else
        flash[:error] = @export.errors.full_messages.join(". ")
      end
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    raise "stub!"
  end

  def destroy
    raise "stub!"
  end

private

  def export_params
    params.require(:export).permit(:database_name)
  end
end
