class Vote < ActiveRecord::Base
  validates :petition_id, uniqueness: {scope: :user_id}
end
