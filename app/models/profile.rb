class Profile < BazaModels::Model
  validates :name, :database_type, presence: true

  def self.translated_database_types
    types = {}
    Baza.drivers.each do |driver|
      types[driver.fetch(:camel_name)] = driver.fetch(:snake_name)
    end

    types
  end

  def translated_database_type
    Profile.translated_database_types.each do |translation, database_type_i|
      return translation if database_type == database_type_i
    end

    ""
  end

  def driver_options
    driver = Baza.drivers.detect { |driver_i| driver_i.fetch(:snake_name) == database_type }

    if driver
      driver.fetch(:class).args
    else
      []
    end
  end

  def parsed_connect_options
    if connect_options?
      YAML.load(connect_options).to_hash
    else
      {}
    end
  end

  def connect_option_value(option_name)
    parsed_connect_options[option_name.to_s]
  end

  def with_db
    db_args = {
      type: database_type
    }.merge(parsed_connect_options.symbolize_keys)

    Baza::Db.new(db_args) do |db|
      yield db
    end
  end

  def databases
    ArrayEnumerator.new do |yielder|
      with_db do |db|
        db.databases.each do |database|
          yielder << database
        end
      end
    end
  end
end
