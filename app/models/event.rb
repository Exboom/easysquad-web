class Event < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :game
  belongs_to :player, optional: true
end
