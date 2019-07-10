class Chekin < ApplicationRecord

  validates :chekin,
            :inclusion => {:in => [true, false]}
  # validates :presence,
  #           :inclusion => { :in => [true, false] }
  belongs_to :player
  belongs_to :team
  belongs_to :game
  belongs_to :reason, optional: true
end
