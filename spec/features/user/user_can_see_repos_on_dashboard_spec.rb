# frozen_string_literal: true

require 'rails_helper'

describe 'As a logged in user' do
  describe 'visiting their dashboard' do
    describe 'I see a section for github' do
      it 'shows a list of my repos', :vcr do
        user = create(:user, github_token: ENV['GITHUB_PAT'])

        visit '/'

        click_link 'Sign In'

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_on 'Log In'

        within '#github' do
          expect(page).to have_content('GitHub')
          expect(page).to have_all_of_selectors('#repo-1', '#repo-2', '#repo-3', '#repo-4', '#repo-5')
        end
      end
    end

    describe 'when I confirm my email' do
      it 'I should see my status change to active' do
        user1 = create(:user, email_confirmed: true)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit '/dashboard'

        expect(page).to have_content("Status: Active")
      end
    end

    describe 'if I do not confirm my email' do
      it 'I should see my status as inactive' do
        user1 = create(:user, email_confirmed: false)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit '/dashboard'

        expect(page).to have_content("Status: Inactive")
      end
    end
  end
end
