require 'spec_helper'

describe Car do
  describe "validations" do
    describe "price" do
      it "validates presence" do
        car = Car.new(make: 'Ford', model: 'Fusion', year: 2007, price: 2350.00)

        # Runs car.valid? and verifies it returns true
        expect(car).to be_valid

        car.price = nil
        expect(car).to_not be_valid
        expect(car.errors[:price]).to be_present
      end

      it "validates value is between 0.01 and 999_999.99" do
        car = Car.new(make: 'Ford', model: 'Fusion', year: 2007, price: 2350.00)

        expect(car).to be_valid

        car.price = 0.00
        expect(car).to_not be_valid
        expect(car.errors[:price]).to be_present

        car.price = 1_000_000.00
        expect(car).to_not be_valid
        expect(car.errors[:price]).to be_present
      end
    end
  end
end
