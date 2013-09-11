class QuestionsController < ApplicationController
  before_filter :enforce_logged_in, except: [:index, :show]

  def index
    @questions = Question.includes(:answers, :user, :votes, :tags)
    @questions = @questions.sort_by{ |question| -question.rating }
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
    # eager load of all the things
    @question = Question.includes(
      [{:answers => [{:comments => :user}, :user, :votes]},
      {:comments => :user},
      :user,
      :votes]
    ).find(params[:id])

    if @question
      # Here, we sort answers by negative rating so that the highest
      # rated appear closest to the top. We could explicitly pull out the
      # accepted answer and then reassamble the list with it first, but it's
      # much simpler to just give it a huge effective rating.
      @answers = @question.answers.sort_by do |answer|
        answer.id == @question.best_answer_id ? -2_000_000_000 : -answer.rating 
      end
      render :show
    else
      render text: "Question #{params[:id]} not found", status: 404
    end
  end

  def new
    render :new
  end
  
  def update
    @question = Question.find(params[:id])

    if @question && @question.update_attributes(params[:question])
      render json: @question
    else
      render_errors_of @question
    end
    
  end
end
