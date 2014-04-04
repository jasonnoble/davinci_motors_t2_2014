class CarsController < ApplicationController
  before_action :find_car, only: [:show, :edit, :update, :destroy, :claim]

  def index
    @cars = Car.where(user_id: nil)
  end

  def my_cars
    @cars = Car.where(user: current_user)
    render action: 'index'
  end

  def claim
    @car.user = current_user
    if @car.save
      redirect_to root_path,
        notice: "#{@car.make} #{@car.model} has been moved to your inventory"
    else
      redirect_to root_path,
        error: "Unable to claim car"
    end
  end

  def show
  end

  def new
    @car = Car.new
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to cars_path, notice: "#{@car.year} #{@car.make} #{@car.model} updated"
    else
      render :edit
    end
  end


  def destroy
    @car.destroy
    redirect_to cars_path, notice: "#{@car.year} #{@car.make} #{@car.model} was removed"
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to cars_path, notice: "#{@car.year} #{@car.make} #{@car.model} created"
    else
      render :new
    end
  end

  private
  def find_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:make, :model, :year, :price)
  end
end
