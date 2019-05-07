class Chekin < ApplicationRecord

  validates :chekin,
            :inclusion => { :in => [true, false] }
  # validates :presence,
  #           :inclusion => { :in => [true, false] }
end
