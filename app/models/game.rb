class Game < ApplicationRecord
  has_many :chekins, dependent: :destroy
  has_many :events
  belongs_to :tournament
  belongs_to :location

  belongs_to :teamg_one, class_name:'Team', foreign_key: "team_one"
  belongs_to :teamg_two, class_name:'Team', foreign_key: "team_two"
end
