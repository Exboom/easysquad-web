class Federation < ApplicationRecord
  has_many :tournaments, foreign_key: :federation_id
end
