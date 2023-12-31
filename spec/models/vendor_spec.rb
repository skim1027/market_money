require 'rails_helper'

RSpec.describe Vendor do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:contact_name) }
    it { should validate_presence_of(:contact_phone) }
    it { should allow_value(true).for(:credit_accepted) }
    it { should allow_value(false).for(:credit_accepted) }
    it { should validate_exclusion_of(:credit_accepted).in_array([nil]) }
  end

  describe 'relationship' do
    it { should have_many(:market_vendor)}
    it { should have_many(:markets).through(:market_vendor)}
  end
end