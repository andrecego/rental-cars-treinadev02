class Manufacturer < ApplicationRecord
  validates :name, presence: { message: 'Nome precisa ser preenchido' }
  validates :name, uniqueness: { message: 'Nome já está em uso '}
  has_many :car_models
end