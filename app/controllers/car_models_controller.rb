class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end
  
  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end
  
  def create
    @car_model = CarModel.new(car_model_params)
    if @car_model.save
      flash[:notice] = 'Modelo de carro criado com sucesso'
      redirect_to @car_model
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  private
  def car_model_params
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type,
                                      :manufacturer_id, :car_category_id)
  end
end