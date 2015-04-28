require 'spec_helper'

describe User do
  before(:each) do 
    @user = FactoryGirl.create(:user)
  end

  it "must be valid user" do
    expect(@user).to be_valid
  end
  context "validation" do
    it "should not have empty email" do 
      @user.email = ''
      expect(@user).to_not be_valid
    end

    it "shoud not have wrong email" do 
      @user.email = Random.alphanumeric
      expect(@user).to_not be_valid
    end

    it 'should not have empty first name' do
      @user.first_name = ''
      expect(@user).to_not be_valid
    end

    it 'should not have empty last name' do
      @user.last_name = ''
      expect(@user).to_not be_valid
    end
  end
end 