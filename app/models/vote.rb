class Vote < ActiveRecord::Base
  attr_accessible :answer_id, :is_up, :question_id, :user_id
end
