class OutfitSelectionRule < ApplicationRecord
    validates :priority, presence: true
    validates :priority, uniqueness: { scope: [:min_temperature_lower_bound, :min_temperature_upper_bound, :max_temperature_lower_bound, :max_temperature_upper_bound] }
end
