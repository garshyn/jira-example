require 'rails_helper'

RSpec.describe JourneyMap, type: :model do
  describe 'validation' do
    it 'is has a valid factory' do
      expect(build(:journey_map)).to be_valid
    end

    it 'is invalid without title' do
      expect(build(:journey_map, title: nil)).not_to be_valid
    end
  end
end
