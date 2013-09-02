class QuestionsController < ApplicationController
  before_filter :enforce_logged_in, except: [:index, :show]

  def index
    @questions = Question.all
    render :index
  end

  def create
    params[:question][:user_id] = current_user || 1 #TODO: enforce login
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
    #TODO
  end

  def show
    @question = Question.includes(:answers => :user).find(params[:id])
    if @question
      render :show
    else
      render text: "Question #{params[:id]} not found", status: 404
    end
  end

  def update
    #TODO
  end

  def new
    render :new
  end

  def edit
    #TODO
  end
end
