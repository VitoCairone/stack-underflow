class Question < ActiveRecord::Base
  attr_accessible :best_answer_id, :body, :title, :user_id, :view_count

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  def upvotes
    @votes ||= self.votes
    votes.select { |vote| vote.is_up }.length
  end

  def downvotes
    @votes ||= self.votes
    votes.select { |vote| !vote.is_up }.length
  end

  def rating
    upcount = upvotes
    2 * upcount - @votes.length
  end
end
