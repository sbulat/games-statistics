class Game < ApplicationRecord
  attr_accessor :player

  belongs_to :title
  belongs_to :user

  serialize :score, JSON
  serialize :result, JSON
  serialize :additional_info, JSON

  validates :score, :result, has_at_least_one_value: true
  validate :played_at_is_valid_date

  after_save :update_favs_counters

  def match_player_to_data
    # temp vars: s - score, r - result, ai - additional_info
    s = {}
    r = {}
    ai = {}

    player.each_with_index do |p, i|
      next if p.empty?
      s[p] = score[i]
      r[p] = result[i]
      ai[p] = additional_info[i]
    end

    self.score = s
    self.result = r
    self.additional_info = ai
  end

  def user_score
    score[user.display_name] || score.values.first
  end

  def user_result
    result[user.display_name] || result.values.first
  end

  private

  def played_at_is_valid_date
    return if played_at <= Time.current

    errors.add(:played_at, 'data gry nie może być późniejsza od dzisiejszej')
  end

  def update_favs_counters
    fav = user.favorites.where(title_id: title_id).first
    return unless fav
    fav.update_attributes(played_games: fav.played_games + 1)
  end
end
