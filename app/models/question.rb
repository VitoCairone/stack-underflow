class Question < ActiveRecord::Base
  attr_accessible :best_answer_id, :body, :title, :user_id, :view_count, :tag_ids

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

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
  
  def vote_of_current_user
    return nil unless logged_in?
    @votes ||= self.votes
    idx = @votes.index {|vote| vote.user_id == current_user.id}
    idx ? @votes[idx] : nil
  end 
end
