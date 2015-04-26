# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cars = Car.create([
                  {make: 'Toyota', model: 'Camry', year: 2006, cost_per_mile: 0.0875},
                  {make: 'Honda', model: 'Accord', year: 2008, cost_per_mile: 0.088}])
