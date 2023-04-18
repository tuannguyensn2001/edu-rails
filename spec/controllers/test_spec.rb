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

  describe '#create_content' do
    let(:test_id) { 1 }
    let(:file_path) { 'test_path' }
    let(:score) { 10 }
    let(:answer) { 'test answer' }
    let(:answer_score) { 5 }

    let(:params) do
      {
        test_id: test_id,
        multiple_choice: {
          file_path: file_path,
          score: score,
          answers: [
            {
              answer: answer,
              score: answer_score,
              type: 'TestMultipleChoiceAnswer'
            }
          ]
        }
      }
    end

    context 'when the service returns an error' do
      it 'returns a bad request status with the error message' do
        mock_service = instance_double(TestService::CreateContent, call: nil, errors: ["Test not found"],error?: true)
        expect(TestService::CreateContent).to receive(:new).and_return(mock_service)
        post :create_content, params: params

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ errors: 'Test not found' }.to_json)
      end
    end

    context 'when the service succeeds' do

      it 'returns a success message' do
        mock_service = instance_double(TestService::CreateContent, call: nil, errors: [],error?: false)
        expect(TestService::CreateContent).to receive(:new).and_return(mock_service)

        post :create_content, params: params

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: 'ok' }.to_json)
      end
    end
  end
end
