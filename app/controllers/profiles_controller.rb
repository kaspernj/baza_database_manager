class ProfilesController < ApplicationController
  load_and_authorize_resource

  def index
    @ransack = Profile.ransack(params[:q])
    @profiles = @ransack
      .result
      .accessible_by(current_ability)
      .page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    assign_driver_options

    if @profile.save
      redirect_to @profile
    else
      flash[:error] = @profile.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
  end

  def update
    assign_driver_options

    if @profile.update_attributes(profile_params)
      redirect_to @profile
    else
      flash[:error] = @profile.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
  end

private

  def profile_params
    params.require(:profile).permit(:name, :database_type)
  end

  def assign_driver_options
    return unless params[:database_options]
    @profile.connect_options = YAML.dump(params[:database_options].to_hash)
  end
end
