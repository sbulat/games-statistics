class Title < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites
  has_many :games

  enum score_type: %i[goals points]

  validates :name, :score_type, presence: true
  validates :name, uniqueness: true

  scope :accepted, (-> { where(accepted: true) })

  def user_played_games(user)
    user.games.where(title_id: id).count
  end
end
