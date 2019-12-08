class CarCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @car_categories = CarCategory.all
  end

  def new
    @car_category = CarCategory.new
  end
  
  def create
    @car_category = CarCategory.new(car_category_params)
    if @car_category.save
      flash[:notice] = 'Categoria criada com êxito'
      redirect_to @car_category
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end
  
  def update
    @car_category = CarCategory.find(params[:id])
      if @car_category.update_attributes(car_category_params)
        flash[:notice] = 'Categoria atualizada com sucesso'
        redirect_to @car_category
      else
        flash[:alert] = 'Algo deu errado'
        render 'edit'
      end
  end
  
    
  private
  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end