require "rails_helper"

RSpec.describe Contest::GetScore do
  let (:test_content) {create(:test_content)}
  let (:session) {create(:contest_session, test: test_content.test)}
  let (:params) { { session_id: session.id, user_id: session.user_id } }

  describe '#call' do
    context "when session belongs to the user" do
      it 'should return correct score' do

        answers = test_content.testable.test_multiple_choice_answers
        session.answers.create(question_id: answers[0].id, answer: answers[0].answer)
        session.answers.create(question_id: answers[1].id, answer: answers[1].answer)

        expected_score = answers[0].score + answers[1].score
        service = described_class.new(params)
        score = service.call
        expect(score).to eq(expected_score)

      end
    end
  end
end
