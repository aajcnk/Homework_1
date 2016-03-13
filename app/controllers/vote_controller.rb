class VoteController < ApplicationController
  
  def upvote
    @petition = Petition.find(params[:id])
    @petition.votes.create
  	redirect_to(petitions_path)
  end
end
