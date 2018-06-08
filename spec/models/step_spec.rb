require 'rails_helper'

RSpec.describe Step, type: :model do
  describe 'validation' do
    it 'has a valid factory' do
      expect(build(:step)).to be_valid
    end

    it 'is invalid without title' do
      expect(build(:step, title: nil)).not_to be_valid
    end

    it 'is invalid without journey map' do
      expect(build(:step, journey_map: nil)).not_to be_valid
    end
  end
end
