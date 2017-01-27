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

  def show
    with_db do
      respond_to do |format|
        format.html { render }
        format.sql do
          @database.use
          dump = Baza::Dump.new(db: @db, debug: true)
          str_io = StringIO.new
          dump.dump(str_io)

          send_data str_io.string, filename: "#{@export.database_name}.sql"
        end
      end
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
        redirect_to [@profile, @database, @export]
      else
        flash[:error] = @export.errors.full_messages.join(". ")
        render :new
      end
    end
  end

  def edit
    with_db do
      render
    end
  end

  def update
    with_db do
      if @export.update_attributes(export_params)
        redirect_to [@profile, @database, @export]
      else
        flash[:error] = @export.errors.full_messages.join(". ")
        render :edit
      end
    end
  end

  def destroy
    with_db do
      if @export.destroy
        redirect_to [@profile, @database]
      else
        flash[:error] = @export.errors.full_messages.join(". ")
        redirect_to :back
      end
    end
  end

private

  def export_params
    params.require(:export).permit(:database_name, :driver_for_export)
  end
end
