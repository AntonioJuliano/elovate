class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show, :create]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :ensure_user_match, only: [:update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/[id]
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(create_user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/[id]
  def update
    if @user.update(update_user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/[id]
  def destroy
    @user.destroy

    render status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_user_match
    render status: :unauthorized unless @user == @current_user
  end

  def create_user_params
    params.require(:user).permit(:username, :first_name, :last_name)
  end

  def update_user_params
    params.require(:user).permit(:username, :first_name, :last_name)
  end
end
