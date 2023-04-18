require 'rails_helper'

RSpec.describe TestContent, type: :model do
  let(:test) { create(:test) }
  let(:test_content) { build(:test_content, test: test) }

  it 'belongs to a test' do
    expect(TestContent.reflect_on_association(:test).macro).to eq(:belongs_to)
  end

  it 'belongs to a testable object' do
    expect(TestContent.reflect_on_association(:testable).macro).to eq(:belongs_to)
  end

  it 'is valid with a test and a testable object' do
    expect(test_content).to be_valid
  end

  it 'is invalid without a test' do
    test_content.test = nil
    expect(test_content).not_to be_valid
  end

  it 'is invalid without a testable object' do
    test_content.testable = nil
    expect(test_content).not_to be_valid
  end
end
