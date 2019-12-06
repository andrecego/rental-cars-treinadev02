class ManufacturersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    @manufacturer = Manufacturer.new
  end
  
  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:success] = "Filial criada com exito"
      redirect_to @manufacturer
    else
      flash[:error] = "Algo deu errado"
      render :new
    end
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update(manufacturer_params)
      flash[:success] = "Filial atualizada com exito"
      redirect_to @manufacturer
    else
      flash[:error] = "Algo deu errado"
      render :edit
    end
  end

  private
  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end