class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  helper_method :streak_winner, :current_streak, :paul, :oli

  def index
    @games = Game.order('created_at DESC')#.limit(20)
    @game  = Game.new
  end

  def top_combinations
  end

  def show
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to new_game_path, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params[:game].permit!
    end

    def streak_winner
      Game.last_win.winner
    end

    def current_streak
      streak_winner.streaks.last
    end

    def paul
      Player.find_by_name('Paul')
    end

    def oli
      Player.find_by_name('Oli')
    end
end
