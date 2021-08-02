class Filer < ApplicationRecord
  has_many :filings
  has_many :awards, -> { distinct }, through: :filings

  validates :ein, presence: true
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
