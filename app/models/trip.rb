class Trip < ActiveRecord::Base
    has_one :car
end
