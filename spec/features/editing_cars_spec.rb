require 'spec_helper'

feature "Editing Cars" do
  scenario "allows you to update the car info" do
    @car = Car.create(make: 'Toyota', model: 'Corolla', year: 2008, price: 3456.67)
    @car2 = Car.create(make: 'Honda', model: 'Civic', year: 2008, price: 33456.67)

    visit '/'

    #within("#car_#{@car.id}") do
    #  click_link 'Edit'
    #end

    click_link "edit_car_#{@car.id}"

    fill_in 'Price', with: 7890.83
    click_button 'Update Car'

    within("#car_#{@car.id}") do
      expect(page).to have_content("$7,890.83")
    end
  end
end