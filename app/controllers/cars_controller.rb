class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = 'Carro cadastrado com sucesso'
      redirect_to @car
    else
      flash[:alert] = 'Algo deu errado'
      @car_models = CarModel.all
      @subsidiaries = Subsidiary.all
      render :new
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  private
  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage,
                                :car_model_id, :subsidiary_id)
  end
end