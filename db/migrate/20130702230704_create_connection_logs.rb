class CreateConnectionLogs < ActiveRecord::Migration
  def change
    create_table :connection_logs do |t|
      t.string :ip
      t.belongs_to :user

      t.timestamps
    end
  end
end
