require "rails_helper"
RSpec.describe TestService::CreateContent, type: :service do
  let(:test) { FactoryBot.create(:test) }
  let(:params) { { test_id: test.id, multiple_choice: { file_path: 'example.pdf', score: 10, answers: [{ answer: 'A', score: 5 }, { answer: 'B', score: 3 }] } } }

  describe '#call' do
    context 'when given valid parameters' do
      it 'creates a new TestMultipleChoice instance with associated TestMultipleChoiceAnswers' do
        expect { described_class.call(params) }.to change(TestMultipleChoice, :count).by(1).and change(TestMultipleChoiceAnswer, :count).by(2)
      end

      it 'creates a new TestContent instance with the new TestMultipleChoice as the testable object' do
        described_class.call(params)
        expect(TestContent.last.testable).to eq(TestMultipleChoice.last)
      end

      it 'updates an existing TestContent instance with the new TestMultipleChoice as the testable object' do
        TestContent.create!(test: test, testable: create(:test_multiple_choice))
        described_class.call(params)
        expect(TestContent.last.testable).to eq(TestMultipleChoice.last)
      end
    end

  end
end
