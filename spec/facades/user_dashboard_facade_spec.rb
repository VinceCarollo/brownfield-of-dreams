# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDashboardFacade do
  before :each do
    @user1 = create(:user, github_username: 'vincecarollo', github_token: ENV['GITHUB_PAT'])
    @facade = UserDashboardFacade.new(@user1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it 'can get repositories of current user', :vcr do
    repos = @facade.repos

    expect(repos.length).to eq(5)
    expect(repos.first).to be_a Repo
  end

  it 'can get followers of current user', :vcr do
    followers = @facade.followers

    expect(followers.length).to eq(4)
    expect(followers.first).to be_a Visitor
  end

  it 'can get followings of current user', :vcr do
    following = @facade.following

    expect(following.length).to eq(6)
    expect(following.first).to be_a Visitor
  end

  it 'can retrieve all users github handles' do
    user2 = create(:user, github_username: 'Vince')
    handles = @facade.all_users

    expect(handles).to include(@user1.github_username)
    expect(handles).to include(user2.github_username)
  end

  it 'can retrieve all bookmarked videos' do
    attributes = {
      position: 1,
      title: 'video1',
      description: 'description',
      tutorial_id: 2,
      video_id: 2
    }

    video = @user1.videos.create!(attributes)

    videos = @facade.bookmarked_videos

    expect(videos.first).to be_a Video
    expect(videos.first.title).to eq(video.title)
    expect(videos.first.description).to eq(video.description)
  end

  it 'can tell if user is current friend' do
    user2 = create(:user, github_username: 'Vince')
    visitor1 = Visitor.new(login: user2.github_username)
    visitor2 = Visitor.new(login: 'Jason')

    @user1.friendships << user2

    expect(@facade.user_friend?(visitor1)).to be true
    expect(@facade.user_friend?(visitor2)).to be false
  end
end
