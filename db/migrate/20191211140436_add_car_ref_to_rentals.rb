class AddCarRefToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :car, foreign_key: true
  end
end
