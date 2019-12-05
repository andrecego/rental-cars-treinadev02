class CarsController < ApplicationController
  def index
    
  end

  def new
    @car = Car.new
  end
end