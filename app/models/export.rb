class Export < BazaModels::Model
  belongs_to :profile

  validates :profile, presence: true
end
