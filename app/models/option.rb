class Option < ApplicationRecord
  belongs_to :question
  validates :description, presence: true
  validates :description, uniqueness: { scope: :question_id,
    message: "should have unique description per question" }
end
