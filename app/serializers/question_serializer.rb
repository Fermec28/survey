class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_many :options
end
