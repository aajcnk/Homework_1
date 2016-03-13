class PetitionsController < ApplicationController
  before_action :authorize, only: [:new, :create]

  def index
    @petitions = Petition.all
    @petitions = @petitions.where(user: current_user) if params[:my]
  end

  def new
    @petition = current_user.petitions.new
  end

  def create
    @petition = current_user.petitions.create(permitted_params)
      if @petition.save
        redirect_to @petition, notice: 'Петиция добавлена.'
      else
        render :new
      end
  end

  def show
    @petition = Petition.find(params[:id])
  end
  
  def edit
    @petition = Petition.find(params[:id])
  end

  def update
    @petition = Petition.find(params[:id])
    if @petition.update(permitted_params)
      flash[:success] = "Петиция обновлена"
      redirect_to @petition
    else
      render :edit
    end
  end

  # def delete
  #   @petition = Petition.find(params[:id])
  #   @petition.destroy
  #   # flash[:success] = "Петиция удалена."
  #   redirect_to petitions_path
  # end
  def delete
    petition[:user_id] = nil
    flash[:success] = "Петиция удалена"
    params[:my] = true
    redirect_to petitions_path(my: true)
  end

  private

  def permitted_params
    params.require(:petition).permit(:id, :title, :text)
  end
end
