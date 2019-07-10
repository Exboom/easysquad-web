class Game < ApplicationRecord
  has_many :chekins, dependent: :destroy
  has_many :events
  belongs_to :tournament
  belongs_to :location
  # belongs_to :team
end
