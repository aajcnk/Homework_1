class PetitionsController < ApplicationController

  def index
    @petitions = Petition.all
    if params[:my]
      @petitions = @petitions.where(user: current_user)
      render 'my_index'
    end
  end

  def new
    @petition = current_user.petitions.new
  end

  def create
    @petition = current_user.petitions.create(permitted_params)
      if @petition.save
        UserMailer.petition_to_review(@user).deliver_now
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

  def delete
    petition = current_user.petitions.find(params[:id])
    petition.destroy
    redirect_to action: :index, notice: 'Петиция удалена'
  end

  private

  def permitted_params
    params.require(:petition).permit(:title, :text)
  end
end
