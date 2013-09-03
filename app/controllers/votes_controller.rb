class VotesController < ApplicationController
  before_filter :enforce_logged_in

  # helper, TODO: DRY (from CommentsController)
  def on_answer?
    @on_answer = params.has_key?(:answer_id)
  end

  # helper, TODO: DRY (from CommentsController)
  def set_context
    if on_answer?
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
    else
      @question = Question.find(params[:question_id])
    end
  end

  def create
    #Get associated objects and set extra paramaters
    set_context
    params[:vote][:user_id] = current_user.id
    if on_answer?
      params[:vote][:answer_id] = params[:answer_id]
    else
      params[:vote][:question_id] = params[:question_id]
    end

    #Actually save the vote
    @vote = Vote.new(params[:vote])
    if @vote.save
      redirect_to :back
    else
      render_errors_of @vote
    end
  end

  def destroy
    destroy_this Vote
  end
end
