class Step < ApplicationRecord
  belongs_to :journey_map
  has_many :fields

  validates :title, presence: true
end
