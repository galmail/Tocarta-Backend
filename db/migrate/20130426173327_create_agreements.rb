class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string  :rol
      t.string  :locale
      t.integer :revision
      t.string  :title
      t.string  :description
      t.text    :content
      t.timestamps
    end
  end
end
