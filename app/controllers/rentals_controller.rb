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
    @car = Car.find(@rental.car_id) if @rental.car_id
    @models = @rental.car_category.car_models.select{|model| model.free?}
  end

  def search
    @rental = Rental.where(reservation_code: params[:q]).take
    redirect_to @rental
  end

  def confirm
    @rental = Rental.find(params[:id])
    @model = CarModel.find(params.require(:car_category).permit(:car_models)[:car_models])
    @car = @model.cars.select{|car| car.available?}.first
    if @rental.save
      @rental.car_id = @car.id
      @car.unavailable!
      @rental.in_progress!
      flash[:notice] = 'Locação efetivada com sucesso'
      redirect_to @rental
    else
      flash[:alert] = 'Algo deu errado'
      render :start
    end      
  end

  private
  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end
end