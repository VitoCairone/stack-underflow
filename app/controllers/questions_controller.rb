class QuestionsController < ApplicationController
  before_filter :enforce_logged_in, except: [:index, :show]

  def index
    @questions = Question.includes(:answers)
    render :index
  end

  def create
    params[:question][:user_id] = current_user.id
    params[:question][:best_answer_id] = -1
    params[:question][:view_count] = 0
    @question = Question.new(params[:question])
    if @question.save
      redirect_to question_url(@question)
    else
      render_errors_of @question
    end
  end

  def destroy
    destroy_this Question
  end

  def show
    @question = Question.includes(:answers => :user).find(params[:id])
    if @question
      render :show
    else
      render text: "Question #{params[:id]} not found", status: 404
    end
  end

  def new
    render :new
  end
end
