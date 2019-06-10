class Location < ApplicationRecord
  has_many :tournaments, foreign_key: :location
end
