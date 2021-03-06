class TitlesController < ApplicationController
  def index
    @all_titles = current_user.try(:admin?) ? Title.all : Title.accepted
    @titles = @all_titles.order(:name)
    @titles = @titles.where("LOWER(name) LIKE '%#{params[:q].downcase}%'") if params[:q]
    @titles = @titles.paginate(page: params[:page], per_page: 10)
  end

  def new
    @title = Title.new
    authorize! :create, @title
  end

  def create
    @title = Title.new(title_params)
    authorize! :create, @title

    if @title.save
      flash[:notice] =
        @title.accepted? ? 'Dodano tytuł' : 'Tytuł musi zatwierdzić admin'
      redirect_to titles_path
    else
      flash[:notice] = 'Wystąpił błąd podczas zapisu'
      render 'new'
    end
  end

  def show
    @title = Title.find(params[:id])
    @all_games = current_user.games.where(title_id: @title.id)
    @games = @all_games.order(played_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @title = Title.find(params[:id])
    authorize! :update, @title
  end

  def update
    @title = Title.find(params[:id])
    authorize! :update, @title

    if @title.update_attributes(title_params)
      flash[:notice] = 'Zaktualizowano tytuł'
      redirect_to titles_path
    else
      flash[:notice] = 'Wystąpił błąd podczas aktualizacji'
      render 'edit'
    end
  end

  def destroy
    @title = Title.find(params[:id])

    flash[:notice] =
      if @title.destroy
        'Usunięto tytuł'
      else
        'Wystąpił błąd podczas usuwania tytułu'
      end

    redirect_to titles_path
  end

  def accept
    @title = Title.find(params[:id])
    authorize! :accept, @title

    if @title.update_attributes(accepted: true)
      redirect_to titles_path, notice: "Zaakceptowano: #{@title.name}"
    else
      redirect_to titles_path, notice: 'Nie udało się zaakceptować'
    end
  end

  def favorite
    return unless current_user

    favorite = Favorite.new(user_id: current_user.id, title_id: params[:id])
    authorize! :create, favorite

    if favorite.save
      redirect_to titles_path, notice: 'Dodano do ulubionych'
    else
      redirect_to titles_path, notice: 'Wystąpił błąd'
    end
  end

  private

  def title_params
    params[:title][:accepted] = current_user.admin?
    params.require(:title).permit(:name, :score_type, :accepted)
  end
end
