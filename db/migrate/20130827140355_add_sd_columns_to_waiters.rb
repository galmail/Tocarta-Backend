class AddSdColumnsToWaiters < ActiveRecord::Migration
  def up
    add_column(:waiters, :sd_userid, :integer)
    add_column(:waiters, :sd_employeeid, :integer)
  end

  def down
    remove_column(:waiters, :sd_userid)
    remove_column(:waiters, :sd_employeeid)
  end
end
