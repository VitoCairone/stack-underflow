class Tagging < ActiveRecord::Base
  attr_accessible :question_id, :tag_id, :user_id

  belongs_to :tag
  belongs_to :user
  belongs_to :question
end
