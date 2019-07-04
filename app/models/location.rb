class Location < ApplicationRecord
  # has_many :tournaments, foreign_key: :location
  has_many :games
  has_and_belongs_to_many :tournaments
end
