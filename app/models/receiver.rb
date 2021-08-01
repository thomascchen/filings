class Receiver < ApplicationRecord
  has_many :awards
  has_many :filings, through: :awards
  has_many :addresses, -> { distinct }, through: :awards, source: :receiver_address

  validates :ein, presence: true, uniqueness: true
  validates :name, presence: true
end
