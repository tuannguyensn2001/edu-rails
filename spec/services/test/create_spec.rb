require 'rails_helper'

RSpec.describe TestService::Create do
  let(:params) { { name: 'test 1', time_to_do: 60 } }

  describe '#call' do
    context 'when Test  is valid and saved successfully' do
      it 'returns the Test object' do
        service = described_class.new(params)
        result = service.call
        expect(result).to be_an_instance_of(Test)
        expect(Test.count).to eq(1)
        expect(Test.first.name).to eq(params[:name])
        expect(Test.first.time_to_do).to eq(params[:time_to_do])

      end
    end

    context 'when Test  is invalid' do
      it 'returns an error message data not valid' do
        invalid_params = params.merge(name: '')
        service = described_class.new(invalid_params)
        service.call
        expect(service.errors.first.message).to eq('data not valid')
        expect(Test.count).to eq(0)
      end
    end
  end
end
