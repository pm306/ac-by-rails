# == Schema Information
#
# Table name: cloth_types
#
#  id             :bigint           not null, primary key
#  name           :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cloth_group_id :bigint
#
# Indexes
#
#  index_cloth_types_on_cloth_group_id  (cloth_group_id)
#  index_cloth_types_on_name            (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (cloth_group_id => cloth_groups.id)
#
class ClothType < ApplicationRecord
  has_many :clothes
  belongs_to :cloth_group

  validates :name, presence: true, uniqueness: true
end
