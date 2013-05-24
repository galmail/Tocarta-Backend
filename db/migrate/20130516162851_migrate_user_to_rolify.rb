class MigrateUserToRolify < ActiveRecord::Migration
  def up
    users = User.all

    users.each do |u|
      unless u.role.nil?
        u.add_role u.role.to_sym
      end
    end

    remove_column :users, :role
  end

  def down
  end
end
