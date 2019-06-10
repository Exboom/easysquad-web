class Tournament < ApplicationRecord
  belongs_to :federation
  belongs_to :location
end
