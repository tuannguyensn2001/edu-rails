require 'rails_helper'

RSpec.describe TestMultipleChoice, type: :model do
  let(:test_multiple_choice) { build(:test_multiple_choice) }

  it 'is valid with a file path and score' do
    expect(test_multiple_choice).to be_valid
  end

  it 'is invalid without a file path' do
    test_multiple_choice.file_path = nil
    expect(test_multiple_choice).not_to be_valid
  end

  it 'is invalid without a score' do
    test_multiple_choice.score = nil
    expect(test_multiple_choice).not_to be_valid
  end

  it 'has many test_multiple_choice_answers' do
    expect(TestMultipleChoice.reflect_on_association(:test_multiple_choice_answers).macro).to eq(:has_many)
  end

  it 'destroys associated test_multiple_choice_answers when destroyed' do
    test_multiple_choice.save!
    create(:test_multiple_choice_answer, test_multiple_choice: test_multiple_choice)
    expect { test_multiple_choice.destroy }.to change { TestMultipleChoiceAnswer.count }.by(-1)
  end

  it 'has one test_content' do
    expect(TestMultipleChoice.reflect_on_association(:test_content).macro).to eq(:has_one)
  end

end
