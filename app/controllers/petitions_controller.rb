class PetitionsController < ApplicationController
	def index
    
  end

  def new
    @petition = Petition.new
  end

  def create
    @petition = Petition.create(petition_params)
    if @petition.save
      redirect_to root_url, notice: "Вы создали петицию"
    else
      render "new"
    end
  end
  
  private

  def petition_params
    params.require(:petition).permit(:title, :text, :user_id)
  end
end
