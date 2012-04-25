class RemoveColumnsSectionAndSubsectionFromDishes < ActiveRecord::Migration
  def change
    remove_column :dishes, :section_id
    remove_column :dishes, :subsection_id
  end
end
