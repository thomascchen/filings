class Receiver < ApplicationRecord
  has_many :awards
  has_many :filings, -> { distinct }, through: :awards

  # There were a few receivers with no EIN
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
