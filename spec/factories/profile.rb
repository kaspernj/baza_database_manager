FactoryBot.define do
  factory :profile do
    sequence(:name) { |n| "Profile #{n}" }
    database_type "sqlite3"
    connect_options do |profile|
      tempfile = Tempfile.new([profile.name, ".sqlite3"])
      path = tempfile.path
      tempfile.close!

      YAML.dump("path" => path)
    end

    after :create do |profile|
      profile.with_db(debug: false) do |db|
        db.tables.create(
          :test_table,
          columns: [
            {name: :id, type: :int, autoincr: true, primarykey: true},
            {name: :name, type: :varchar}
          ],
          indexes: [:name]
        )
      end
    end
  end
end
