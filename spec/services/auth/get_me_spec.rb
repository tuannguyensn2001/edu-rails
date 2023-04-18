require "rails_helper"

RSpec.describe Auth::GetMe do
  describe "#call" do
    let(:user) { create(:user) }

    context "when the user exists" do
      it "returns the user" do
        service = described_class.new(user.id)

        result = service.call

        expect(result).to eq(user)
      end
    end

    context "when the user does not exist" do
      it "returns an error" do
        service = described_class.new(-1)

        service.call
        
        expect(service.error?).to be_truthy
      end
    end
  end
end