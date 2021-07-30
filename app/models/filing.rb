class Filing < ApplicationRecord
  validates_presence_of :data
  validates_presence_of :url
end
