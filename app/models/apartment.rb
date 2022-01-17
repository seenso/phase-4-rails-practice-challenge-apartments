class Apartment < ApplicationRecord
  has_many :tenants
  has_many :leases, through: :tenants

  validates :number, presence: true
end
