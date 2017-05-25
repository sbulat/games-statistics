class GamesController < ApplicationController
  def index
    return unless current_user
    @games = current_user.games.order(played_at: :desc)
    @games = @games.joins(:title).where('titles.name = ?', params[:q]) if params[:q]
    @games = @games.paginate(page: params[:page], per_page: 20)
  end

  def new
    @game = Game.new(title_id: params[:title_id], user_id: current_user.id)
  end

  def create
    @game = Game.new(game_params)
    @game.match_player_to_data

    if @game.save
      redirect_to games_path, notice: 'Dodano partię'
    else
      flash[:notice] = 'Wystąpił błąd podczas dodawania partii'
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def destroy
    game = Game.find(params[:id])

    if game.destroy
      redirect_to games_path, notice: 'Usunięto partię'
    else
      redirect_to games_path, notice: 'Wystąpił błąd podczas usuwania partii'
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
