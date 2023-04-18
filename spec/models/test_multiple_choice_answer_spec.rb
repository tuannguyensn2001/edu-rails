require 'rails_helper'

RSpec.describe TestMultipleChoiceAnswer, type: :model do
  let(:test_multiple_choice) { create(:test_multiple_choice) }

  describe '#save' do
    let(:valid_attributes) do
      {
        answer: 'Option A',
        score: 5,
        test_multiple_choice_id: test_multiple_choice.id
      }
    end

    context 'with valid attributes' do
      it 'saves the answer' do
        answer = described_class.new(valid_attributes)
        expect(answer.save).to be true
      end
    end

    context 'with missing answer attribute' do
      it 'does not save the answer and returns an error' do
        attributes = valid_attributes.except(:answer)
        answer = described_class.new(attributes)
        expect(answer.save).to be false
        expect(answer.errors.full_messages).to include("Answer can't be blank")
      end
    end

    context 'with missing score attribute' do
      it 'does not save the answer and returns an error' do
        attributes = valid_attributes.except(:score)
        answer = described_class.new(attributes)
        expect(answer.save).to be false
        expect(answer.errors.full_messages).to include("Score can't be blank")
      end
    end

    context 'with missing test_multiple_choice_id attribute' do
      it 'does not save the answer and returns an error' do
        attributes = valid_attributes.except(:test_multiple_choice_id)
        answer = described_class.new(attributes)
        expect(answer.save).to be false
        expect(answer.errors.full_messages).to include("Test multiple choice must exist")
      end
    end
  end
end
