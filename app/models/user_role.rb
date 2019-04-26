class UserRole < ApplicationRecord
  include PgSearch
  pg_search_scope :search_everywhere, against: [:user]
end
