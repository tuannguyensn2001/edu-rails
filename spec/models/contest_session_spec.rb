require 'rails_helper'

RSpec.describe ContestSession, type: :model do
  let (:user) { create(:user) }
  let (:test) { create(:test) }
  subject { described_class.new(user_id: user.id, test_id: test.id, session_code: "ABC123", status: "START") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a user_id" do
      subject.user_id = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a test_id" do
      subject.test_id = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a session_code" do
      subject.session_code = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a status" do
      subject.status = nil
      expect(subject).not_to be_valid
    end
  end

end
