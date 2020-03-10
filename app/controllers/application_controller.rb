class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # redirect to dashboard index after
  # devise sign in
  def after_sign_in_path_for(resource)
    user_homes_path(resource)
  end


  def index
  end
end
