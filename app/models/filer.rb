class Filer < ApplicationRecord
  has_many :filings
  has_many :addresses, -> { distinct }, through: :filings, source: :filer_address
  has_many :awards, -> { distinct }, through: :filings

  validates :ein, presence: true, uniqueness: true
  validates :name, presence: true
end
