class VotesController < ApplicationController
  before_filter :enforce_logged_in

  def create
    #Get associated objects and set extra paramaters
    set_context
    params[:vote] = {}
    params[:vote][:is_up] = params[:is_up]
    params[:vote][:user_id] = current_user.id
    if on_answer?
      params[:vote][:answer_id] = params[:answer_id]
    else
      params[:vote][:question_id] = params[:question_id]
    end

    #Actually save the vote
    @vote = Vote.new(params[:vote])
    if @vote.save
      render json: @vote
    else
      render_errors_of @vote
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote
      #TODO: fail non-owned destroy more loudly
      @vote.destroy if owned(@vote)
      render json: @object, status: 200
    else
      render_errors_of @object
    end
  end
  
end
