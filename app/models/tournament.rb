class Tournament < ApplicationRecord
  belongs_to :federation
  # belongs_to :location

  has_and_belongs_to_many :locations

  has_many :games
  has_many :applications

  has_many :team_tournaments
  has_many :teams, through: :team_tournaments
end
