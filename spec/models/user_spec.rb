require 'spec_helper'

describe User do

  context "basic validations" do
    before :each do
      @user = build(:user)
    end

    it "is valid with email" do
      expect(@user).to be_valid
    end

    it "is invalid without email" do
      expect(build(:invalid_user)).to have(1).errors_on(:email)
    end

    it "is invalid with duplicated email" do
      create(:user, email: 'test@test.com')
      user2 = build(:user, email: 'test@test.com')
      expect(user2).to have(1).errors_on(:email)
    end
  end

end
