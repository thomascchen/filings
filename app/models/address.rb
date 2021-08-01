class Address < ApplicationRecord
  has_many :filings, foreign_key: :filer_address_id
  has_many :filers, -> { distinct }, through: :filings

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
