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
          send_file dump_to_tempfile.path, filename: "#{@export.database_name}.sql.gz"
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
        redirect_back(fallback_location: :root)
      end
    end
  end

private

  def export_params
    params.require(:export).permit(:database_name, :driver_for_export)
  end

  def dump_to_tempfile
    @database.use

    tempfile = Tempfile.new(["baza-database-manager-export", ".sql.gz"])
    tempfile.binmode

    zlib_writer = Zlib::GzipWriter.new(tempfile)

    dumper = Baza::Dump.new(db: @db, db_type: @export.driver_for_export, debug: false)
    dumper.dump(zlib_writer)

    zlib_writer.close
    tempfile.close

    tempfile
  end
end
