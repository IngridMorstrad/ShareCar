class Trip < ActiveRecord::Base
    has_one :car
    has_many :passenger
    validates :distance, presence: true, numericality: {greater_than: 0}
    validates :origin, :destination, :start_time, :end_time, presence: true
end
