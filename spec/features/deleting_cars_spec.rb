require 'spec_helper'

feature "Deleting Cars" do
  scenario "allows you to delete a car" do
    @car = Car.create(make: 'Toyota', model: 'Corolla', year: 2008, price: 3456.67)
    @car2 = Car.create(make: 'Honda', model: 'Civic', year: 2008, price: 33456.67)

    visit '/'

    within("#car_#{@car.id}") do
      click_link 'Delete'
    end

    expect(page).to have_content("2008 Toyota Corolla was removed")
    expect(page).to_not have_css("#car_#{@car.id}")
  end
end