# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :thumbnail }
  end

  describe 'relationships' do
    it { should have_many :videos }
    it { should accept_nested_attributes_for :videos }
  end

  describe 'class methods' do
    it '.non_classroom' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)

      tutorial = Tutorial.non_classroom

      expect(tutorial).to include(tutorial1)
      expect(tutorial).to_not include(tutorial2)
    end
  end
end
