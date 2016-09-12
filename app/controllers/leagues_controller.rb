class LeaguesController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]
  before_action :lookup_league, only: [:show, :update, :destroy]
  before_action :validate_user_is_manager, only: [:update, :destroy]

  # GET /leagues
  def index
    render json: League.all
  end

  # POST /leagues
  def create
    league = League.new(create_params)
    entry = Entry.new(user: @current_user, league: league, name: params[:entry_name])

    if league.save
      render json: league, status: :created
    else
      render json: league.errors, status: :unprocessable_entity
    end
  end

  # GET /leagues/[id]
  def show
    render json: @league
  end

  # PATCH/PUT /leagues/[id]
  def update
    if !update_params.empty? && @league.update(update_params)
      render json: @league
    else
      render status: :unprocessable_entity
    end
  end

  # DELETE /leagues/[id]
  def destroy
    if @league.destroy
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  private

  def lookup_league
    @league = League.find(params[:id])
  end

  def validate_user_is_manager
    matching_entry = @current_user.entries.where(league: @league).first

    unless matching_entry && matching_entry.manager?
      render status: :unauthorized
    end
  end

  def create_params
    params.require(:league).permit(:name, :description)
  end

  def update_params
    params.require(:league).permit(:name, :description)
  end
end
