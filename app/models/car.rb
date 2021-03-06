class Car < ActiveRecord::Base
    belongs_to :trip
    has_many :owner, dependent: :delete_all
    validates :make, :model, :year, :seats, :cost_per_mile, presence: true
    validates :cost_per_mile, numericality: {greater_than: 0}
    validates :seats, numericality: {only_integer: true, greater_than: 0}
    validates :year, numericality: {only_integer: true, greater_than: 1900}

    def human_name
    	"#{self.make} #{self.model} #{self.year}"
    end
end
