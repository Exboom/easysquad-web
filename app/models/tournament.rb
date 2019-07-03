class Tournament < ApplicationRecord
  belongs_to :federation
  belongs_to :location

  has_many :games
  has_many :applications

  has_many :team_tournaments
  has_many :teams, through: :team_tournaments
end
