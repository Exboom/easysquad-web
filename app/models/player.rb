class Player < ApplicationRecord
  has_many :teams
  has_many :chekins, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :events

  has_many :player_teams, dependent: :destroy
  has_many :teams, through: :player_teams
end
