class Receiver < ApplicationRecord
  validates :ein, presence: true, uniqueness: true
  validates :name, presence: true
end
