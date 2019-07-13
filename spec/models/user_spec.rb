# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many :videos }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'class methods' do
    it '.all_github_usernames' do
      user1 = create(:user, github_username: 'rocketman')
      user2 = create(:user, github_username: 'jetman')

      usernames = User.all_github_usernames

      expect(usernames).to be_a Array

      expect(usernames.first).to eq(user1.github_username)
      expect(usernames.last).to eq(user2.github_username)
    end
  end

  describe 'instance methods' do
    it '#email_activate' do
      user = create(:user)

      expect(user.email_confirmed).to be false
      expect(user.confirm_token).to_not eq(nil)

      user.email_activate

      expect(user.email_confirmed).to be true
      expect(user.confirm_token).to eq(nil)
    end

    it '#all_friend_github_handles' do
      user1 = create(:user, github_username: 'Github Username 1')
      user2 = create(:user, github_username: 'Github Username 2')
      user3 = create(:user, github_username: 'Github Username 3')
      user4 = create(:user, github_username: 'Github Username 4')
      user1.friendships << user2
      user1.friendships << user3

      handles = user1.all_friend_github_handles

      expect(handles).to be_a Array
      expect(handles).to include(user2.github_username)
      expect(handles).to include(user3.github_username)
      expect(handles).to_not include(user4.github_username)
    end
  end
end
