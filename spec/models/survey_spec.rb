require 'rails_helper'

RSpec.describe Survey, type: :model do
  context "DB Model validation" do 
      it {validate_presence_of(:description)}
      it {is_expected.to belong_to :user }
  end
end
