class Award < ApplicationRecord
  belongs_to :filer
  belongs_to :filing
  belongs_to :receiver
  belongs_to :receiver_address, class_name: "Address"

  validates :cash_amount, presence: true, numericality: true
  validates :purpose, presence: true
end
