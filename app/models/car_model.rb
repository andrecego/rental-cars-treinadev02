class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars

  def free?
    cars.any?{|car| car.status == 'available'}
  end

  def full_name
    manufacturer.name + ' ' + name
  end
end