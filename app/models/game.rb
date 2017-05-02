class Game < ApplicationRecord
  attr_accessor :player

  belongs_to :title
  belongs_to :user

  serialize :score, JSON
  serialize :result, JSON
  serialize :additional_info, JSON

  validate :played_at_is_valid_date

  def match_player_to_data
    s = r = ai = {} # temp vars: s - score, r - result, ai - additional_info
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

  private

  def played_at_is_valid_date
    if Time.zone.parse(played_at) > Time.current
      errors.add(:played_at, 'data gry nie może być późniejsza od dzisiejszej')
    end
  # rescue
  #   errors.add(:played_at, 'zły format daty')
  end
end
