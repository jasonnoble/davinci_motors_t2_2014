require 'spec_helper'

feature "Creating Cars" do
  scenario "can create a car" do
    visit '/'

    click_link 'New Car'

    fill_in 'Make', with: 'Ford'
    fill_in 'Model', with: 'Mustang'
    fill_in 'Year', with: '1967'
    fill_in 'Price', with: '2300'

    click_button 'Create Car'

    expect(page).to have_content('1967 Ford Mustang created')

    visit '/'

    car = Car.first

    within("tr#car_#{car.id}") do
      expect(page).to have_content('1967')
      expect(page).to have_content('Ford')
      expect(page).to have_content('Mustang')
      expect(page).to have_content('$2,300.00')
    end
  end

  scenario "can create a second car" do
    car = Car.create(make: 'Chevrolet', model: 'Impala', year: '2002', price: 345.57)

    visit '/'

    expect(page).to have_content('2002')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Impala')
    expect(page).to have_content('$345.57')

    click_link 'New Car'

    fill_in 'Make', with: 'Chrysler'
    fill_in 'Model', with: 'Sebring'
    fill_in 'Year', with: '1937'
    fill_in 'Price', with: '23000.80'

    click_button 'Create Car'

    expect(page).to have_content('1937 Chrysler Sebring created')

    visit '/'
    expect(page).to have_content('1937')
    expect(page).to have_content('Chrysler')
    expect(page).to have_content('Sebring')
    expect(page).to have_content('$23,000.80')
  end
end