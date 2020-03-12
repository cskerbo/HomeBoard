class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  after_action :clear_xhr_flash
  # redirect to dashboard index after
  # devise sign in
  def after_sign_in_path_for(resource)
    user_homes_path(resource)
  end

  def index
  end

  def clear_xhr_flash
    if request.xhr?
      flash.discard
    end
  end

end
