require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit "users/new"
    expect(page).to have_content("Please Sign Up!")
  end

  feature 'signing up a user' do
    
    scenario 'shows email on the homepage after signup' do
      visit "users/new"
      fill_in "Email", with: "testing@email.com"
      fill_in "Password", with: "passwurd"
      click_on "Create User"
      expect(page).to have_content("testing@email.com")
    end

  end
end

feature 'logging in' do
  user = create_user
  
  scenario 'shows username on the homepage after login' do
    visit "session/new"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign In"
    expect(page).to have_content(user.email)
    expect(current_path).to eq("/users/#{user.id}")
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end