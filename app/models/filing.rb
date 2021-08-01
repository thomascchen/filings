class Filing < ApplicationRecord
  belongs_to :filer
  belongs_to :filer_address, class_name: "Address"
  has_many :awards
  has_many :receivers, -> { distinct }, through: :awards

  validates :url, presence: true
  validates :xml, presence: true
end
