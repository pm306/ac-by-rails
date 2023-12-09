# == Schema Information
#
# Table name: cloth_groups
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_cloth_groups_on_name  (name) UNIQUE
#
class ClothGroup < ApplicationRecord
  DEFAULT_SELECT_NUMBER = 0

  has_many :cloths,                 dependent: :destroy
  has_many :cloth_group_selections, dependent: :destroy
  has_many :outfit_selection_rules, through: :cloth_group_selections

  validates :name, presence: true, uniqueness: true
end
