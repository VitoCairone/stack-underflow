class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      login(@user)
      redirect_to home_url
    else
      render_errors_of @user
    end
  end

  def new
    render :new, locals: { action_url: users_url }
  end

  def destroy
    # if the user being destroyed is logged in, they are implicitly 'logged out'
    # because their session token no longer exists in the users table
    destroy_this User
  end
  
  def index
    @users = User.all
    render :index
  end
  
  def show
    @no_editor = true
    @user = User.find(params[:id])
    render :show
  end
end
