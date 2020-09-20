class QuestionStatisticSerializer < ActiveModel::Serializer
    attributes :id, :description, :total_count
    has_many :options, include_nested_associations: true
    
    def total_count
        object.options.responses_count
    end
    class OptionSerializer < ActiveModel::Serializer
      attributes :id, :description, :count

      def count
        object.responses.count
      end
    end
  end