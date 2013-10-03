class AddPosIpAddressToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :pos_ip_address, :string
  end
end
