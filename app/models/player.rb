class Player < ApplicationRecord
  # belongs_to :user

  has_many :teams, foreign_key: :player_id
  has_many :chekins
  has_many :applications

  has_many :player_teams
  has_many :teams, through: :player_teams
end
