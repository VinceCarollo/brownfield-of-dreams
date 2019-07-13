# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TutorialFacade do
  before :each do
    tutorial = create(:tutorial)
    @video1 = create(:video, position: 1)
    @video2 = create(:video, position: 2)
    tutorial.videos << @video1
    tutorial.videos << @video2

    @facade = TutorialFacade.new(tutorial, @video1.id)
  end

  it 'can get current video' do
    current_video = @facade.current_video

    expect(current_video).to eq(@video1)
  end

  it 'can get next video' do
    current_video = @facade.next_video

    expect(current_video).to eq(@video2)
  end

  it 'can check play next video' do
    expect(@facade.play_next_video?).to be true
  end

  it 'can order videos' do
    videos = @facade.ordered_videos

    expect(videos.first).to eq(@video1)
    expect(videos.last).to eq(@video2)
  end
end
