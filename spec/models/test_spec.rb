require 'rails_helper'

RSpec.describe Test, type: :model do
  let(:test) { build(:test) }

  # describe 'validations' do
  #   it { should validate_presence_of(:name) }
  #   it { should validate_uniqueness_of(:name) }
  #   it { should validate_presence_of(:time_to_do) }
  # end

  describe 'attributes' do
    it 'is valid with valid attributes' do
      expect(test).to be_valid
    end

    it 'is not valid without a name' do
      test.name = nil
      expect(test).to_not be_valid
    end

    it 'is not valid without a time to do' do
      test.time_to_do = nil
      expect(test).to_not be_valid
    end

    it 'is not valid with a duplicate name' do
      create(:test, name: 'Test Name')
      test.name = 'Test Name'
      expect(test).to_not be_valid
    end
  end
end
