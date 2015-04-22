class Trip < ActiveRecord::Base
    has_one :car
    has_many :passenger
end
