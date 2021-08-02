require 'rails_helper'

RSpec.describe Receiver, type: :model do
  describe "associations" do
    it { should have_many(:awards) }
    it { should have_many(:filings) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
