require 'rails_helper'

RSpec.describe User, type: :model do

  context "DB Model validation" do 
    it { have_db_index(:email)}
    it {validate_uniqueness_of(:email)}
  end

  describe 'Invalid User creation' do
    it "without attributes" do
      expect(User.new).to_not be_valid
    end

    it "with wrong password_confirmation" do
      expect(User.new(email: "user@user.com", password_confirmation: "test1", password: "test")).to_not be_valid
    end    
  end
end
