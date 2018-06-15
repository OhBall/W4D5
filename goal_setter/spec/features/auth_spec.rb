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
  
  scenario 'shows username on the homepage after login' do
    user = login_new_user
    expect(page).to have_content(user.email)
    expect(current_path).to eq("/users/#{user.id}")
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit "session/new"
    expect(page).not_to have_content("You are signed in!")
  end
  scenario 'doesn\'t show username on the homepage after logout' do
    user = login_new_user
    click_on "Sign Out"
    expect(page).not_to have_content(user.email)
    expect(current_path).to eq("/session/new")
  end

end