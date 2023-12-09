# == Schema Information
#
# Table name: outfit_selection_rules
#
#  id                          :bigint           not null, primary key
#  description                 :text(65535)
#  max_temperature_lower_bound :float(24)
#  max_temperature_upper_bound :float(24)
#  min_temperature_lower_bound :float(24)
#  min_temperature_upper_bound :float(24)
#  name                        :string(255)      not null
#  priority                    :integer          not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
# Indexes
#
#  index_outfit_selection_rules_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :outfit_selection_rule do
    name { 'MyString' }
    description { 'MyText' }
    priority { 1 }
  end
end
