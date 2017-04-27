class Game < ApplicationRecord
  belongs_to :title
  belongs_to :user
end
