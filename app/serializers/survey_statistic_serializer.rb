# class SurveyStatisticSerializer < ActiveModel::Serializer
#   has_many :questions, include_nested_associations: true
#   class QuestionSerializer < ActiveModel::Serializer
#     attributes :id, :description, :responses_count
#     has_many :options, include_nested_associations: true
  
#     class OptionSerializer < ActiveModel::Serializer
#       attributes :id, :description, :responses_count
    
#       def response_count
#         self.responses.count
#       end
#     end
#   end
# end

class SurveyStatisticSerializer < ActiveModel::Serializer
  attributes :id, :description
   has_many :questions, include_nested_associations: true

   class QuestionSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers
      attributes :id, :description
      attribute :links do
        id = object.id
        {
          statistics: api_v1_survey_question_statistics_path(survey_id: object.survey.id,question_id:id)
        }
      
      end 
      
  end
end

