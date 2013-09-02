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
    #TODO
  end

  def show
    #TODO
  end

  def update
    #TODO
  end

  def new
    #TODO
  end

  def edit
    #TODO
  end
end
