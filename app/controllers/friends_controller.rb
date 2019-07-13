# frozen_string_literal: true

class FriendsController < ApplicationController
  def update
    user = User.find_by(github_username: params[:github_username])
    if user
      current_user.friendships << user
    else
      flash[:notice] = "Friend not found."
    end
    redirect_to dashboard_path
  end
end
