# frozen_string_literal: true
BazaModels::Model.extend Devise::Models

class User < BazaModels::Model
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
