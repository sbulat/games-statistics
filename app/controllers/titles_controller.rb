class TitlesController < ApplicationController
  def index
    @titles = current_user.try(:admin?) ? Title.all : Title.accepted
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
    params.require(:title).permit(:name, :accepted)
  end
end
