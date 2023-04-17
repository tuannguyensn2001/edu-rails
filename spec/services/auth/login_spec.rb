require 'rails_helper'

RSpec.describe Auth::Login, type: :service do
  # let(:user) { create(:user, email: 'tuannguyensn2001a@gmail.com', password: BCrypt::Password.create("123456")) }
  let(:valid_params) { { email: 'tuannguyensn2001a@gmail.com', password: "123456" } }
  let(:invalid_params) { { email: 'tuannguyensn2001a@gmail.com', password: '1234567' } }
  let(:jwt_secret) { "hello" }

  describe '#call' do
    context 'when given valid credentials' do
      before do
       create(:user, email: 'tuannguyensn2001a@gmail.com', password: BCrypt::Password.create("123456"))
      end
      it 'returns  access and refresh tokens' do
        service = described_class.new(valid_params, jwt_secret)
        result = service.call
        expect(result).to include(:access_token, :refresh_token)
      end
      it "trigger notify job" do
        expect(NotifyUserLoginJob).to receive(:perform_later).with(User.last.id)
        service = described_class.new(valid_params, jwt_secret)
        service.call
      end
    end

    context 'when given invalid credentials' do
      it "returns an error message when email not valid" do
        invalid_params.merge(email: 'tuannguyensn2001a')
        service = described_class.new(invalid_params, jwt_secret)
        service.call
        expect(service.error?).to be_truthy
      end

      it 'returns an error message when password not valid' do
        service = described_class.new(invalid_params, jwt_secret)
        service.call
        expect(service.error?).to be_truthy
      end
    end
  end


end