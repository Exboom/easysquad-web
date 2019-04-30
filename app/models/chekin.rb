class Chekin < ApplicationRecord

  validates :chekin,
            :inclusion => { :in => [true, false] }
end
