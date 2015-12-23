BazaModels.primary_db = Baza::Db.new(
  type: :sqlite3,
  path: "#{File.dirname(__FILE__)}/../../db/baza_#{Rails.env}.sqlite3",
  append: true,
  debug: false,
  type_translation: true
)
Baza.default_db = BazaModels.primary_db

BazaModels.load_can_can
