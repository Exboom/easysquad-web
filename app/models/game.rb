class Game < ApplicationRecord
  has_many :chekins
  belongs_to :tournament
  # belongs_to :team
end
