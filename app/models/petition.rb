class Petition < ActiveRecord::Base
	belongs_to :user
	has_many :votes
	scope :expired?, -> (time) { where( "created_at < ACTIVE", time) } 
	ACTIVE = 30.day
	VOTES  = 100

	def voted_by?(user)
    votes.where(user_id: user.id).any?
  end

  def voting
  	@petition.votes.count >= VOTES
  end
end
