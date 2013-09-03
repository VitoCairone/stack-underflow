class Vote < ActiveRecord::Base
  attr_accessible :answer_id, :is_up, :question_id, :user_id

  belongs_to :user
  belongs_to :answer
  belongs_to :question
end
