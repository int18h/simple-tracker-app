require 'spec_helper'

describe User do
  before { @user = FactoryGirl.create :user }
  subject {@user}
  
  context "validation rules" do

    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :last_name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password }
    it { is_expected.to respond_to :password_confirmation }

    it { is_expected.to be_valid }    

    context "for user bio" do
      it { is_expected.to validate_presence_of :first_name }
      it { is_expected.to validate_presence_of :last_name }
      it "must have full name" do
        expect(subject.full_name).not_to eq('')
      end
    end
    
    context "for user email" do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_uniqueness_of :email }  
    end

  end

end 