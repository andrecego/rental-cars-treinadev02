class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:notice] = 'Cliente registrado com sucesso'
      redirect_to @client
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @client = Client.find(params[:id])
  end
  
  
  private
  def client_params
    params.require(:client).permit(:name, :document, :email)
  end
end