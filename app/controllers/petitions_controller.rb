class PetitionsController < ApplicationController
  before_action :authorize, only: [:new, :create]
    
  def index
    @petition = Petition.all
    @petition = @petition.where(user: current_user) if params[:my]
  end

  def new
    @petition = current_user.petitions.new
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def create
    petition = current_user.petitions.create(petition_params)
    redirect_to petition
  end
  
  private

  def petition_params
    params.require(:petition).permit(:title, :text, :id)
  end
end
