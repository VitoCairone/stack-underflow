class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :user_id
end
