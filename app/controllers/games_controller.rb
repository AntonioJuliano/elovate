class GamesController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]
  before_action :lookup_league
  before_action :validate_user_in_league, only: [:create, :update, :destroy]
  before_action :lookup_game, only: [:show, :update, :destroy]

  # GET /games
  def index
    render json: @league.games
  end

  # POST /games
  def create
    game = Game.generate(@league, JSON.parse(params[:game]).deep_symbolize_keys!)

    if game.valid?
      render json: game, status: 200
    else
      render json: game.errors, status: 422
    end
  end

  # GET /games/[id]
  def show
    render json: @game
  end

  # PATCH/PUT /games/[id]
  def update
    # TODO
  end

  # DELETE /games/[id]
  def destroy
    # TODO
  end

  private

  def lookup_league
    @league = League.find(params[:league_id])
  end

  def lookup_game
    @game = @league.games.find(params[:id])
  end

  def validate_user_in_league
    @current_user.entries.each do |e|
      return true if e.league == @league
    end

    render status: 403
  end
end
