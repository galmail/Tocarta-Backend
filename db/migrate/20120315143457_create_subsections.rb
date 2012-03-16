class CreateSubsections < ActiveRecord::Migration
  def change
    create_table :subsections do |t|
      t.references :section
      t.string :name

      t.timestamps
    end
    add_index :subsections, :section_id
  end
end
