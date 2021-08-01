class Filing < ApplicationRecord
  belongs_to :filer
  belongs_to :filer_address, class_name: "Address"

  validates :url, presence: true
  validates :xml, presence: true
end
