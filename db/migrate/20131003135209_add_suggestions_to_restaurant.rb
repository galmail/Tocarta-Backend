class AddSuggestionsToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :suggestions, :text
  end
end
