class ApplicationController < ActionController::Base
  protect_from_forgery

  include ApplicationHelper
  # include SessionsController::SessionsHelper #this also does not work
  # include SessionsHelper
end
