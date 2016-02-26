class CreateExports < BazaMigrations::Migration
  def change
    create_table :exports do |t|
      t.belongs_to :profile
      t.string :database_name
      t.string :driver_for_export
      t.timestamps
    end
  end
end
