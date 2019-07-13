# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitor do
  before :each do
    @person = Visitor.new(
      login: 'garth',
      html_url: 'www.google.com'
    )
  end

  it 'exists' do
    expect(@person).to be_a Visitor
  end

  it 'has attributes' do
    expect(@person.name).to eq('garth')
    expect(@person.link).to eq('www.google.com')
  end
end
