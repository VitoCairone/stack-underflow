class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :user_id

  belongs_to :question
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  def upvotes
    @votes ||= self.votes
    votes.select { |vote| vote.is_up }.count
  end

  def downvotes
    @votes ||= self.votes
    votes.select { |vote| !vote.is_up }.count
  end

  def rating
    upcount = upvotes
    2 * upcount - @votes.length
  end
end
