class VoteController < ApplicationController
  
  # def create
  #   @vote = Vote.new(vote_params)
  #   if @vote.save
  #     session[:user_id] = @user.id
  #     redirect_to root_url, notice: "Спасибо за регистрацию"
  #   else
  #     render 'new'
  #   end
  # end

  def create
    vote = current_user.petitions.create(vote_params)
  end
  
  private
  def vote_params
    params.require(:vote).permit(:user_id, :petition_id)
  end
end
