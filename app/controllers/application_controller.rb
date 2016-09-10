class ApplicationController < ActionController::API
  before_action :authenticate
 
  private
 
  def authenticate
    # TODO
    @current_user = User.where(username: params[:username]).first

    unless @current_user
      render status: :unauthorized
    end
  end
end
