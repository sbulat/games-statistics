class Title < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites
  has_many :games

  scope :accepted, (-> { where(accepted: true) })

  enum score_type: %i[goals points]
end
