class CreateWineDetails < ActiveRecord::Migration
  def up
    create_table :wine_details do |t|
      t.references  :user
      t.string      :name
      t.text        :description
      t.string      :wine_type
      t.string      :wine_cellar
      t.integer     :vintage
      t.string      :country
      t.string      :region
      t.string      :grape_type
      t.string      :pairing
      t.string      :ideal_temperature
      t.string      :color
      t.string      :flavor
      t.string      :aroma
      t.integer     :score
      t.timestamps
    end
    
    add_index :wine_details, :name
    add_index :wine_details, :wine_type
    add_index :wine_details, :vintage
    add_index :wine_details, :country
    add_index :wine_details, :region
    add_index :wine_details, :score
    
    WineDetail.create_translation_table!(
      :name => :string, :description => :text, :wine_type => :string, :country => :string, :region => :string, :grape_type => :string,
      :pairing => :string, :ideal_temperature => :string, :color => :string, :flavor => :string, :aroma => :string)
  end
  
  def down
    WineDetail.drop_translation_table!
  end
end
