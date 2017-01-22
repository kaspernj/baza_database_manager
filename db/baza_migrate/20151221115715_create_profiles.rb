# frozen_string_literal: true
class CreateProfiles < BazaMigrations::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :database_type
      t.text :connect_options
      t.timestamps
    end
  end
end
