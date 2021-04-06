RSpec.describe 'create new user', type: :feature do
  before :each do
    @user = User.create(name: 'exal', email: 'exal@mail.com', password: '123456')
  end
  scenario 'Create new user with valid user and valid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'jbalvin'
    fill_in 'Email', with: 'jbalvin@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'get error if one of fields is not filled' do
    visit new_user_registration_path
    fill_in 'Name', with: nil
    fill_in 'Email', with: 'exal@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content("Name can't be blank")
  end

  it 'User sign in' do
    visit user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
  it 'if email or password in wrong' do
    visit user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'another password'
    click_on 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
