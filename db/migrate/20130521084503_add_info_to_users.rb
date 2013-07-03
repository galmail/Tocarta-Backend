class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :birthdate, :date
    add_column :users, :twitter, :string
    add_column :users, :url, :string
    add_column :users, :phone, :string
  end
end
