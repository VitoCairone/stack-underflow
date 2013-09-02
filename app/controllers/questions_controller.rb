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
      render text: @question.errors.full_messages, status: 422
    end
  end

  def destroy
    #TODO
  end

  def show
    @question = Question.find(params[:id])
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
    #TODO
  end

  def edit
    #TODO
  end
end
