class Award < ApplicationRecord
  belongs_to :filer
  belongs_to :filing
  belongs_to :receiver

  validates :cash_amount, presence: true, numericality: true
  validates :purpose, presence: true
end
