class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :user_id

  belongs_to :question
  belongs_to :user
  has_many :comments
end
