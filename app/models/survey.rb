class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  validates :description, presence: true
end
