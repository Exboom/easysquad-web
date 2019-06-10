class UserRole < ApplicationRecord
  include PgSearch
  pg_search_scope :search_everywhere, against: [:user]

  belongs_to :user
  belongs_to :role
  belongs_to :team
end
