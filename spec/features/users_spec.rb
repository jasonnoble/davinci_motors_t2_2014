require 'spec_helper'

feature "User Authentication" do
  scenario "allows a user to signup" do
    visit "/"

    expect(page).to have_link('Signup')

    click_link 'Signup'

    fill_in 'First name', with: 'Ted'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: 'ted@smith.com'
    fill_in 'Password', with: 'sup3rs3krit'
    fill_in 'Password confirmation', with: 'sup3rs3krit'

    click_button 'Signup'

    expect(page).to have_text('Thank you for signing up Ted')
    expect(page).to have_text('Signed in as ted@smith.com')
  end

  scenario "allows existing user to login" do
    @user = FactoryGirl.create(:user)

    visit "/"

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Login'

    expect(page).to have_text("Welcome back #{@user.first_name}")
    expect(page).to have_text("Signed in as #{@user.email}")
  end

  scenario "does not allow existing user to login with invalid password" do
    @user = FactoryGirl.create(:user)

    visit "/"

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'theWrongPassword'

    click_button 'Login'

    expect(page).to have_text("Invalid email or password")
  end

  scenario "allow a logged in user to logout" do
    @user = FactoryGirl.create(:user)

    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Login'

    visit "/"

    expect(page).to have_text("Signed in as #{@user.email}")

    expect(page).to have_link('Logout')

    click_link 'Logout'

    expect(page).to have_text("#{@user.email} has been logged out")
    expect(page).to_not have_text("Welcome back #{@user.first_name}")
    expect(page).to_not have_text("Signed in as #{@user.email}")
  end

  scenario "allow a logged in user to claim a car" do
    @user = FactoryGirl.create(:user)
    @car1 = FactoryGirl.create(:car)
    @car2 = FactoryGirl.create(:car)

    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Login'

    within("tr#car_#{@car1.id}") do
      click_link 'Claim'
    end

    expect(page).to have_text(
      "#{@car1.make} #{@car1.model} has been moved to your inventory")

    expect(page).to_not have_selector("tr#car_#{@car1.id}")
    expect(page).to have_selector("tr#car_#{@car2.id}")

    expect(page).to have_link('My Cars')

    click_link 'My Cars'
    expect(page).to have_selector("tr#car_#{@car1.id}")
    expect(page).to_not have_selector("tr#car_#{@car2.id}")
  end
end

