class Car < ActiveRecord::Base
    belongs_to :trip
    has_many :owner
    validates :make, :model, :year, :seats, :cost_per_mile, presence: true
    validates :cost_per_mile, numericality: {greater_than: 0}
    validates :seats, numericality: {only_integer: true}
end
