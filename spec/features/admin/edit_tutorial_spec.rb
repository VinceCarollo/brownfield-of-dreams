# frozen_string_literal: true

require 'rails_helper'

describe 'An Admin can edit a tutorial' do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  describe 'by adding a video' do
    it 'works as intended', :vcr do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[title]', with: 'How to tie your shoes.'
      fill_in 'video[description]', with: 'Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through.'
      fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
      expect(Video.last.thumbnail).to eq('https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg')

      within(first('.video')) do
        expect(page).to have_content('How to tie your shoes.')
      end
    end

    it 'Blocks videos with no youtube id' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[title]', with: 'How to tie your shoes.'
      fill_in 'video[description]', with: 'Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through.'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
      expect(page).to have_content('Youtube ID is required')
    end

    it 'Blocks videos with no title' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[description]', with: 'Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through.'
      fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
      expect(page).to have_content("Title can't be blank")
    end

    it 'Blocks videos with no description' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[title]', with: 'How to tie your shoes.'
      fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
      expect(page).to have_content("Description can't be blank")
    end
  end
end
