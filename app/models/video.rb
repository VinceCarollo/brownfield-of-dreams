# frozen_string_literal: true

class Video < ApplicationRecord
  validates_presence_of :position, :title, :description, :video_id

  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.order_by_tutorial_id
    order(:tutorial_id, :position)
  end

  def assign_thumbnail
    self.thumbnail = YouTube::Video.by_id(video_id).thumbnail
    save
  end
end
