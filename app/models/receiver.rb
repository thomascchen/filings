class Receiver < ApplicationRecord
  has_many :awards
  has_many :filings, through: :awards
  has_many :addresses, -> { distinct }, through: :awards, source: :receiver_address

  validates :ein, uniqueness: true, allow_nil: true # There were a few receivers with no EIN
  validates :name, presence: true
end
