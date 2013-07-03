class AddSubtledataFields < ActiveRecord::Migration
  def up
    add_column(:restaurants, :sd_location_id, :integer)
    add_column(:sections,    :sd_category_id, :integer)
    add_column(:dishes,      :sd_dish_id,     :integer)
  end

  def down
    remove_column(:dishes,      :sd_dish_id)
    remove_column(:sections,    :sd_category_id)
    remove_column(:restaurants, :sd_location_id)
  end
end
