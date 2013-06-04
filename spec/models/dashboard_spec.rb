require 'spec_helper'

describe Dashboard do

  context "basic validations" do
    before :each do
      @db = build(:dashboard)
    end

    it "is valid with name" do
      expect(@db).to be_valid
    end

    it "is invalid without name" do
      expect(build(:invalid_dashboard)).to have(1).errors_on(:name)
    end

    it "convert options to hash" do
      expect(@db.options).to be_instance_of(Hash)
    end

    it "is invalid with duplicated name" do
      create(:dashboard, name: 'test')
      db2 = build(:dashboard, name: 'test')
      expect(db2).to have(1).errors_on(:name)
    end
  end

end
