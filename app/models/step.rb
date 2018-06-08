class Step < ApplicationRecord
  belongs_to :journey_map

  validates :title, presence: true
end
