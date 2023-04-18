require 'rails_helper'

RSpec.describe TestController, type: :controller do
  describe '#create' do
    let(:valid_params) { { name: 'Test Name', time_to_do: 60, time_start: Time.current } }
    let(:invalid_params) { { name: '', time_to_do: 60, time_start: Time.current } }

    context 'when input data is valid' do
      it 'returns a success response with message "ok"' do
        mock_service = instance_double(TestService::Create, call: nil, errors: [],error?: false)
        expect(TestService::Create).to receive(:new).and_return(mock_service)

        post :create, params: valid_params

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'ok' })
      end
    end

    context 'when input data is invalid' do
      it 'returns a bad request response with error message' do
        mock_service = instance_double(TestService::Create, call: nil, errors: ["data not valid"],error?: true)
        expect(TestService::Create).to receive(:new).and_return(mock_service)

        post :create, params: invalid_params

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'errors' => 'data not valid' })
      end
    end
  end
end
