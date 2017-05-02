class GamesController < ApplicationController
  def index
    @games = current_user.try(:games)
  end

  def new
    @game = Game.new(title_id: params[:title_id], user_id: current_user.id)
  end

  def create
    @game = Game.new(game_params)
    @game.match_player_to_data

    redirect_to(games_path, notice: 'Test') && return
    if @game.save
      redirect_to games_path, notice: 'Dodano partię'
    else
      flash[:notice] = 'Wystąpił błąd podczas dodawania partii'
      render 'new'
    end
  end

  def player_row
    render partial: 'player_row'
  end

  private

  def game_params
    params
      .require(:game)
      .permit(
        :title_id, :user_id, :played_at, player: [], score: [], result: [], additional_info: []
      )
  end
end