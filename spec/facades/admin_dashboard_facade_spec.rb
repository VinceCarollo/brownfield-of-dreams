# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminDashboardFacade do
  before :each do
    @facade = AdminDashboardFacade.new
  end

  it 'can get all tutorials' do
    create_list(:tutorial, 3)

    tutorials = @facade.tutorials

    expect(tutorials.first).to be_a Tutorial
    expect(tutorials.length).to eq(3)
  end
end
