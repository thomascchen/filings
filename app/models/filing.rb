class Filing < ApplicationRecord
  validates_presence_of :data, :url
end
