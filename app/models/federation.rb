class Federation < ApplicationRecord
  has_many :tournaments, dependent: :destroy
end
