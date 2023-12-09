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
require 'rails_helper'

RSpec.describe ClothGroupSelection, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
