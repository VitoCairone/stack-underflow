class SessionsController < ApplicationController
  def create
    authenticate_and_login
  end

  def new
    render :new, locals: { action_url: session_url, button_label: "Log in" }
  end

  def destroy
    logout_current_user
    redirect_to home_url
  end
end
