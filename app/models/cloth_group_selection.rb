# == Schema Information
#
# Table name: cloth_group_selections
#
#  id                       :bigint           not null, primary key
#  selection_count          :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  cloth_group_id           :bigint           not null
#  outfit_selection_rule_id :bigint           not null
#
# Indexes
#
#  index_cloth_group_selections_on_cloth_group_id            (cloth_group_id)
#  index_cloth_group_selections_on_outfit_selection_rule_id  (outfit_selection_rule_id)
#
# Foreign Keys
#
#  fk_rails_...  (cloth_group_id => cloth_groups.id)
#  fk_rails_...  (outfit_selection_rule_id => outfit_selection_rules.id)
#
class ClothGroupSelection < ApplicationRecord
  belongs_to :outfit_selection_rule
  belongs_to :cloth_group

  validates :selection_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
