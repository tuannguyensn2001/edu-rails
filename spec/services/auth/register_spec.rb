require 'rails_helper'

RSpec.describe Auth::Register, type: :service do
  let(:valid_params) do
    {
      email: "tuannguyensn2001a@gmail.com",
      password: "tuannguyensn2001",
      username: "tuannguyensn2001"
    }
  end

  describe "#call" do
    context "with valid params" do
      it "creates a new user with encrypted password" do
        service = described_class.new(valid_params)
        expect do
          service.call
        end.to change(User, :count).by(1)

        user = User.last
        expect(user.email).to eq("tuannguyensn2001a@gmail.com")
        expect(user.username).to eq("tuannguyensn2001")
        expect(user.password).not_to eq("tuannguyensn2001")
        expect(BCrypt::Password.new(user.password)).to eq("tuannguyensn2001")
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { email: "test@example.com" } }

      it "returns an error data not valid" do
        service = described_class.new(invalid_params)
        service.call

        expect(service.errors.first.message).to eq("data not valid")
        expect(service.error?).to be_truthy
        expect(User.count).to eq(0)
      end
    end
  end
end
