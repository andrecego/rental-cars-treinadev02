class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :subsidiary
  has_one :car_rental
  has_one :car, through: :car_rental
  validates :start_date, :end_date, presence: true
  validate :end_date_must_be_greather_than_start_date

  enum status: {scheduled:0 , in_progress: 5}
  
  def end_date_must_be_greather_than_start_date
    return unless start_date || end_date

    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end
  end

  def cars_available?
    #carros disponiveis
    car_models = CarModel.where(car_category: car_category)
    total_cars = Car.where(car_model: car_models).count

    #locaçoes agendadas
    total_rentals = Rental.where(car_category: car_category, subsidiary: subsidiary)
                          .where("start_date < ? AND end_date >= ?", start_date, start_date)
                          .count

    (total_cars - total_rentals) > 0
  end
end