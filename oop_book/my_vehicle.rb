# 120 OOP Book
# https://launchschool.com/books/oo_ruby/read/inheritance#exercises


module Towable
  def can_tow?(lbs)
    lbs < 2000 ? true : false 
  end 
end 

class Vehicle 

  @@number_of_vehicles = 0

  def self.show_number_of_vehicles
    puts "#{@@number_of_vehicles} vehicles created so far"
  end 

  def self.gas_mileage(gallons, miles)
  puts "#{miles / gallons} miles per gallon gas."
  end

  attr_accessor :year, :model, :color
  #attr_accessor :color
  attr_reader :year

  def initialize(y, m, c)
    @year = y
    @model = m
    @color = c
    @speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(num)
    @speed += num
    puts "Your car accelerated #{num} mph"
  end

  def slow_down(num)
    @speed -= num
    puts "Your car slowed down #{num} mph"
  end

  def brake_car
    @speed = 0
    puts "You stopped the car!"
  end

  def spray_paint(paint)
    @color = paint
  end

  def age 
    "The #{self.model} is #{calculate_age} years old"
  end 

  private 

  def calculate_age
    Time.now.year - self.year
    # ((Time.new - Time.new(year))/(365*24*60*60)).round(2)
  end 

  
end 

class MyCar < Vehicle 
  NUMBER_OF_DOORS = 4 
  def to_s
  "This is a #{color} #{year} #{model}"
  end

end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2 
  include Towable
end 
