require 'rails_helper'

RSpec.describe Receiver, type: :model do
  describe "validations" do
    subject { Receiver.new(ein: "ein", name: "name") }
    it { should validate_presence_of(:ein) }
    it { should validate_uniqueness_of(:ein) }
    it { should validate_presence_of(:name) }
  end
end
