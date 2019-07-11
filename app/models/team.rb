class Team < ApplicationRecord
  belongs_to :user
  belongs_to :player, optional: true
  has_many :events

  has_many :gamet_one, class_name:'Game', foreign_key: "team_one"
  has_many :gamet_two, class_name:'Game', foreign_key: "team_two"

  has_many :applications, dependent: :destroy
  has_many :user_roles, dependent: :destroy

  has_many :player_teams, dependent: :destroy
  has_many :players, through: :player_teams

  has_many :team_tournaments, dependent: :destroy
  has_many :tournaments, through: :team_tournaments
end
