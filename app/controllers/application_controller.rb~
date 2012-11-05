class ApplicationController < ActionController::Base
  protect_from_forgery

  layout "master"

  before_filter :require_user

  def current_user
        Trainer.find(session[:user_id]) if session[:user_id]
  end

  def require_user
        unless current_user
                redirect_to login_url
        end
  end
end

