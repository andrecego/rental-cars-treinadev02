class ApplicationController < ActionController::Base

  private
  def authenticate_admin
    unless current_user.admin?
      flash[:notice] = 'Você não tem essa permissão'      
      redirect_to root_path
    end
  end
end
