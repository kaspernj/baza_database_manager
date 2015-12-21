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
    puts "Profile: #{@profile.inspect}"

    if @profile.save
      redirect_to profile
    else
      flash[:error] = @profile.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def profile_params
    params.require(:profile).permit(:name, :database_type, :connect_options)
  end
end
