class Export < BazaModels::Model
  belongs_to :profile

  validates :driver_for_export, presence: true
end
