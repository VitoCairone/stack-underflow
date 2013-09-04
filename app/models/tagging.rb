class Tagging < ActiveRecord::Base
  attr_accessible :answer_id, :question_id, :tag_id, :user_id
end
