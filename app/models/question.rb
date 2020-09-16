class Question < ApplicationRecord
  belongs_to :survey
  has_many :options
  validates :description, presence: true
end
