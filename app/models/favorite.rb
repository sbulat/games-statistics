class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :title

  validates_uniqueness_of :title_id, scope: [:user_id]
end
