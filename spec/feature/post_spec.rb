require 'rails_helper'

RSpec.describe 'create new post', type: :feature do
  scenario 'Create post with information' do
    visit new_user_registration_path
    fill_in 'Name', with: 'farruko'
    fill_in 'Email', with: 'farruko@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    visit posts_path
    fill_in 'Add New Post', with: 'Het ter'
    click_on 'Save'
    expect(page).to have_content('Post was successfully created.')
  end

  scenario 'Create post without information' do
    visit new_user_registration_path
    fill_in 'Name', with: 'farruko'
    fill_in 'Email', with: 'farruko@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    visit posts_path
    fill_in 'Add New Post', with: ''
    click_on 'Save'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
  end
end
