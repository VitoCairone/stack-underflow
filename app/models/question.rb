class Question < ActiveRecord::Base
  attr_accessible :best_answer_id, :body, :title, :user_id, :view_count

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
end
