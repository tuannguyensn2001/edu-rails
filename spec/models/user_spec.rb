require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user) { build(:user) }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      create(:user, email: user.email)
      expect(user).to_not be_valid
    end

    it "is not valid without a username" do
      user.username = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid with a short password" do
      user.password = "pass"
      expect(user).to_not be_valid
    end
  end
end