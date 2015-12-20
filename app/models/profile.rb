class Profile < BazaModels::Model
  validates :name, :database_type, presence: true
end
