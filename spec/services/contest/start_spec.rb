require 'rails_helper'

RSpec.describe Contest::Start do
  describe '#call' do
    let(:user) { create(:user) }
    let(:test) { create(:test, time_start: Time.now - 1.hour, time_to_do: 90, time_end: Time.now + 2.hour) }
    let(:params) { { user_id: user.id, test_id: test.id } }

    context "when pass invalid test_id" do
      it "return error message not found" do
        params.merge!(test_id: 0)
        service = described_class.new(params)
        service.call
        expect(service.error?).to be_truthy
        expect(service.errors.first.message).to eq('Not found')

      end
    end

    context 'when user has already started the contest' do
      let!(:contest_session) { create(:contest_session, user: user, test: test, status: 'START') }

      it 'returns an error message' do
        service = described_class.new(params)
        service.call
        expect(service.error?).to be_truthy
        expect(service.errors.first.message).to eq('Already started')
      end
    end

    context 'when contest has not yet started' do
      let(:test) { create(:test, time_start: Time.now + 1.hour, time_to_do: 90, time_end: Time.now + 2.hours) }

      it 'returns an error message' do
        service = described_class.new(params)
        service.call
        expect(service.error?).to be_truthy
        expect(service.errors.first.message).to eq('Contest not started')
      end
    end

    context 'when contest has already ended' do
      let(:test) { create(:test, time_start: Time.now - 2.hours, time_to_do: 90, time_end: Time.now - 1.hour) }

      it 'returns an error message' do
        service = described_class.new(params)
        service.call
        expect(service.error?).to be_truthy
        expect(service.errors.first.message).to eq('Contest ended')
      end
    end

    context 'when valid parameters are passed' do
      it 'creates a new contest session' do
        service = described_class.new(params)
        result = service.call
        expect(service.error?).to be_falsey
        expect(result).to be_an_instance_of(ContestSession)
        expect(result.user_id).to eq(user.id)
        expect(result.test_id).to eq(test.id)
        expect(result.session_code).to_not be_blank
        expect(result.status).to eq('START')
      end
    end
  end
end
