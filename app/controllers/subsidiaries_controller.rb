class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end
  
  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      flash[:notice] = 'Filial criada com sucesso'
      redirect_to @subsidiary
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end
  
  def update
    @subsidiary = Subsidiary.find(params[:id])
      if @subsidiary.update_attributes(subsidiary_params)
        flash[:notice] = 'Filial atualizada com sucesso'
        redirect_to @subsidiary
      else
        flash[:alert] = 'Algo deu errado'
        render :edit
      end
  end  

  def destroy
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.destroy
      flash[:notice] = 'Filial apagada com sucesso'
      redirect_to subsidiaries_path
    else
      flash[:alert] = 'Algo deu errado'
      redirect_to subsidiaries_path
    end
  end
  
  private
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end