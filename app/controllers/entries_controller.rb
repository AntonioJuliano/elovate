class EntriesController < ApplicationController
  skip_before_action :authenticate, only: [:show]
  before_action :lookup_entry, only: [:show, :update, :destroy]
  before_action :validate_user_owns_entry, only: [:update, :destroy]

  # POST /entries
  def create
    $redis.lock(lock_name(create_params[:league_id])) do
      entry = Entry.new(
        create_params.merge({ user: @current_user })
      )

      if entry.save
        render json: entry, status: :created
      else
        render json: entry.errors, status: :unprocessable_entity
      end
    end
  end

  # GET /entries/[id]
  def show
    render json: @entry
  end

  # PATCH/PUT /entries/[id]
  def update
    $redis.lock(lock_name(@entry.league.id)) do
      if !update_params.empty? && @entry.update(update_params)
        render json: @entry
      else
        render status: :unprocessable_entity
      end
    end
  end

  # DELETE /entries/[id]
  def destroy
    $redis.lock(lock_name(@entry.league.id)) do
      if @entry.destroy
        render status: :ok
      else
        render status: :unprocessable_entity
      end
    end
  end

  private

  def lock_name(league_id)
    "create_entry_#{league_id}"
  end

  def lookup_entry
    @entry = Entry.find(params[:id])
  end

  def validate_user_owns_entry
    unless @current_user.entries.include?(@entry)
      render status: :unauthorized
    end
  end

  def create_params
    params.require(:entry).permit(:name, :league_id)
  end

  def update_params
    params.require(:entry).permit(:name, :league_id)
  end
end
