class Question < ActiveRecord::Base
  attr_accessible :best_answer_id, :body, :title, :user_id, :view_count
end
