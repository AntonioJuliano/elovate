class ApplicationController < ActionController::API
  before_action :authenticate
 
  private
 
  def authenticate
    # TODO
    @current_user = User.find_by(username: params[:username])
  end
end
