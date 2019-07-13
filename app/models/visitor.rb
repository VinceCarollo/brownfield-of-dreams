# frozen_string_literal: true

class Visitor
  attr_reader :name, :link
  def initialize(follower_info)
    @name = follower_info[:login]
    @link = follower_info[:html_url]
  end
end
