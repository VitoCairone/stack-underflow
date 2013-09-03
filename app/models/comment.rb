class Comment < ActiveRecord::Base
  attr_accessible :answer_id, :body, :question_id, :user_id

  # a particular comment belongs to EITHER a question OR an answer;
  # the other column is null in the DB.
  belongs_to :question
  belongs_to :user
  belongs_to :answer

  def on_answer?
    !self.answer_id.nil?
  end

  def on_question?
    !self.question_id.nil?
  end
end
