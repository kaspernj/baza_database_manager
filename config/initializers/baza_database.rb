BazaModels.primary_db = Baza::Db.new(
  type: :sqlite3,
  path: "#{File.dirname(__FILE__)}/../../db/#{Rails.env}.sqlite3",
  append: true
)
