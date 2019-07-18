class Tournament < ApplicationRecord
  belongs_to :federation

  has_and_belongs_to_many :locations, dependent: :clear

  has_many :games, dependent: :destroy
  has_many :rosters, dependent: :destroy

  has_many :team_tournaments, dependent: :destroy
  has_many :teams, through: :team_tournaments
end
