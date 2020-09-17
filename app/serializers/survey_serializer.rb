class SurveySerializer < ActiveModel::Serializer
  attributes :id, :description
  has_many :questions, include_nested_associations: true
end
