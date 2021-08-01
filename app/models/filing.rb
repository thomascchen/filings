class Filing < ApplicationRecord
  belongs_to :filer
  belongs_to :filer_address, class_name: "Address"
  has_many :awards
  has_many :receivers, -> { distinct }, through: :awards

  validates :tax_year, presence: true, numericality: true
  validates :url, presence: true
  validates :xml, presence: true
end
