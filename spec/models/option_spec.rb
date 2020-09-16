require 'rails_helper'

RSpec.describe Option, type: :model do
  context "DB Model validation" do 
      it {validate_presence_of(:description)}
      it {is_expected.to belong_to :question}
  end

  context "validate uniquenes in  same question" do
    let!(:user) { create(:user) }
    let!(:survey) { create(:survey, user_id: user.id) }
    let!(:question) { create(:question, survey_id: survey.id) }
    it "is not valid without same description" do
        question.options.create(description: "Fer")
        option = question.options.new(description: "Fer")
        expect(option).to_not be_valid
      end
  end
end