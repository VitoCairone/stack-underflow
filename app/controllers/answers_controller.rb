class AnswersController < ApplicationController
  before_filter :enforce_logged_in

  def new
    @question = Question.find(params[:question_id])
    render :new
  end

  def create
    @question = Question.find(params[:question_id])
    params[:answer][:question_id] = @question.id
    params[:answer][:user_id] = current_user.id
    @answer = Answer.new(params[:answer])
    if @answer.save
      redirect_to question_url(@question)
    else
      render_errors_of @answer
    end
  end

  def destroy
    destroy_this Answer
  end

end
