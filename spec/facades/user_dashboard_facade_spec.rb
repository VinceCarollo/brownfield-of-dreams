# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDashboardFacade do
  before :each do
    @user1 = create(:user)
    @facade = UserDashboardFacade.new(@user1)
  end

  it 'can tell if user is current friend' do
    user2 = create(:user, github_username: 'Vince')
    visitor1 = Person.new({login: user2.github_username})
    visitor2 = Person.new({login: 'Jason'})

    @user1.friendships << user2

    expect(@facade.user_friend?(visitor1)).to be true
    expect(@facade.user_friend?(visitor2)).to be false
  end
end
