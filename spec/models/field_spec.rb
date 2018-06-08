require 'rails_helper'

RSpec.describe Field, type: :model do
  describe 'validation' do
    it 'has a valid factory' do
      expect(build(:field)).to be_valid
    end

    it 'is invalid without step' do
      expect(build(:field, step: nil)).not_to be_valid
    end
  end

  describe 'contents' do
    it 'is json' do
      field = create(
        :field,
        contents: '',
      )

      expect(field).to have_attributes(
        contents: {}
      )
    end
  end
end
