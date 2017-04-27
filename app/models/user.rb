class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[user admin]

  has_many :favorites
  has_many :titles, through: :favorites
  has_many :games

  def like?(title_id)
    titles.ids.include?(title_id)
  end
end
