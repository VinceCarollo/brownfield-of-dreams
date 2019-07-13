# frozen_string_literal: true

require 'rails_helper'

describe 'As a registered user' do
  it 'I can confirm my email', :vcr do
    user1 = create(:user)
    token = user1.confirm_token

    visit "http://localhost:3000/users/#{token}/confirm_email"

    expect(current_path).to eq(welcome_path)
    expect(page).to have_content('Thank you! Your account is now activated.')
    binding.pry
  end

  it 'I cant confirm unrecognized token', :vcr do
    visit 'http://localhost:3000/users/aaddwrongToken/confirm_email'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Sorry, User does not exist')
  end
end
