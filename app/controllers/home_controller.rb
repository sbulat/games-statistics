class HomeController < ApplicationController
  def index
    return unless current_user
    @favorites = current_user.favorites
  end
end
