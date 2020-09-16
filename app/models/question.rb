class Question < ApplicationRecord
  belongs_to :survey
  has_many :options, dependent: :destroy
  validates :description, presence: true
end