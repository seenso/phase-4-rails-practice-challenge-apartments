class Tenant < ApplicationRecord
  has_many :apartments
  has_many :leases, through: :through

  validates :name, presence: true
  validates :age, inclusion: 18..200
end
