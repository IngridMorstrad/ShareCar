# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cars = Car.create([
                  {make: 'Toyota', model: 'Camry', year: 2006, cost_per_mile: 0.0875, seats: 4},
                  {make: 'Honda', model: 'Accord', year: 2008, cost_per_mile: 0.088, seats: 6}])
users = User.create([{name: "Jolene", email: "jolene@gmail.com", password: "Jolene", password_confirmation: "Jolene", activated: true}])
owners = Owner.create([{car: cars.first, user: users.first}])
t = Trip.create(distance: 8, car_id: cars.first.id, origin: 'High point woods', destination: 'Epic', new_passenger_cost: 1.1/2*0.945, start_time: DateTime.new(2015,4,1,17), end_time: DateTime.new(2015,4,1,17,30), total_trip_cost: 0.945, completed: false)
Passenger.create(trip_id: t.id, user_id: users.first.id)
