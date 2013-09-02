class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    render :index
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to question_url(@question)
    else
      render json: @question.errors.full_messages, status: 422
    end
  end

  def destroy
  end

  def show
  end

  def update
  end

  def new
  end

  def edit
  end
end
