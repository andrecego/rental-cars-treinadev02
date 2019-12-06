class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  validates :license_plate, :color, :car_model_id, :mileage, :subsidiary_id, 
            presence: { message: 'Todos os campos precisam ser preenchidos' }
  validates :mileage, numericality: { greater_than_or_equal_to: 0, 
                                      message: 'Quilometragem deve ser positiva' }
  validates :license_plate, uniqueness: { message: 'Placa já cadastrada' }
  validates :license_plate, format: { with: /[A-Z]{3}[-]\d{4}/,
                                      message: 'Placa no formato errado' }
end