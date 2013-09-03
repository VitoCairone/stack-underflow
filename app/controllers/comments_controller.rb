class CommentsController < ApplicationController
  before_filter :enforce_logged_in

  # helper
  def on_answer?
    @on_answer = params.has_key?(:answer_id)
  end

  # helper
  def set_context
    if on_answer?
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
    else
      @question = Question.find(params[:question_id])
    end
  end

  def new
    set_context
    @create_url = on_answer? ? answer_comments_url(@answer)
                             : question_comments_url(@question)
    render :new
  end

  def create
    #Get associated objects and set extra paramaters
    set_context
    params[:comment][:user_id] = current_user.id
    if on_answer?
      params[:comment][:answer_id] = params[:answer_id]
    else
      params[:comment][:question_id] = params[:question_id]
    end

    #Actually save the comment and redirect to the question view
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to question_url(@question)
    else
      render_errors_of @comment
    end
  end

  def destroy
    destroy_this Comment
  end

end
