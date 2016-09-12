class ApplicationController < ActionController::API
  before_action :authenticate
  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_unprocessable_entry



  private
 
  def authenticate
    # TODO
    @current_user = User.where(username: params[:username]).first

    unless @current_user
      render status: :unauthorized
    end
  end

  def render_not_found
    render status: :not_found
  end

  def render_unprocessable_entry
    render status: :unprocessable_entry
  end
end
