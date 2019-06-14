class Team < ApplicationRecord
  belongs_to :user
  belongs_to :player
  has_many :user_roles

  has_many :player_teams
  has_many :players, through: :player_teams

  has_many :team_tournaments
  has_many :tournaments, through: :team_tournaments
end
