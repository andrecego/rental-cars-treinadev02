class Manufacturer < ApplicationRecord
  validates :name, presence: { message: 'Nome precisa ser preenchido' }
  validates :name, uniqueness: { message: 'Nome já está em uso '}
end
