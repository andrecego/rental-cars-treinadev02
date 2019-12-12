class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end
  
  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end
  
  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      flash[:notice] = 'Locação cadastrada com sucesso'
      redirect_to @rental
    else
      flash[:alert] = 'Algo deu errado'
      @clients = Client.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def show
    @rental = Rental.find(params[:id])
    @car = @rental.car if @rental.car
    @models = @rental.car_category.car_models.select{|model| model.free?}
  end

  def search
    @rental = Rental.where(reservation_code: params[:q]).take
    redirect_to @rental
  end

  def confirm
    @rental = Rental.find(params[:id])
    @model = CarModel.find(params[:car_category][:car_models])
    @car = @model.cars.select{|car| car.available?}.first
    if @rental.create_car_rental(car: @car)
      @car.unavailable!
      @rental.in_progress!
      flash[:notice] = 'Locação efetivada com sucesso'
      redirect_to @rental
    else
      flash[:alert] = 'Algo deu errado'
      render :show
    end      
  end

  private
  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end
end