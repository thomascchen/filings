require 'rails_helper'

RSpec.describe Receiver, type: :model do
  describe "associations" do
    it { should have_many(:awards) }
    it { should have_many(:filings) }
    it { should have_many(:addresses).through(:awards).source(:receiver_address).conditions("distinct") }
  end

  describe "validations" do
    subject { Receiver.new(ein: "ein", name: "name") }
    it { should validate_uniqueness_of(:ein).allow_nil }
    it { should validate_presence_of(:name) }
  end
end
