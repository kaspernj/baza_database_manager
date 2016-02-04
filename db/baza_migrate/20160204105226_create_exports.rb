class CreateExports < BazaMigrations::Migration
  def change
    create_table :exports do |t|
      t.belongs_to :profile
      t.string :database_name
      t.timestamps
    end
  end
end
