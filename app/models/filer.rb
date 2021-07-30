class Filer < ApplicationRecord
  validates_presence_of :ein, :name, :address, :city, :state, :zip
  validates_uniqueness_of :ein
end
