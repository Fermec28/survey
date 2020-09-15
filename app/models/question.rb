class Question < ApplicationRecord
  belongs_to :survey
  validates :description, presence: true
end
