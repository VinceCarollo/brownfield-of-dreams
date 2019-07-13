require 'rails_helper'

RSpec.describe UserDashboardFacade do

  before :each do
    @user1 = create(:user)
    @facade = UserDashboardFacade.new(@user1)
  end

  it "can tell if user is current friend" do
    user2 = create(:user)
    user3 = create(:user)
    @user1.friendships << user2

    expect(@facade.user_friend?(user2)).to be true
    expect(@facade.user_friend?(user3)).to be false
  end
end
