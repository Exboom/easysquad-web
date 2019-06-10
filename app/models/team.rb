class Team < ApplicationRecord
  belongs_to :user
  belongs_to :player
  has_many :user_roles

  has_many :player_teams
  has_many :players, through: :player_teams
end
