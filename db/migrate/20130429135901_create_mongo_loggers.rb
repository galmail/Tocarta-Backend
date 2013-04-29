class CreateMongoLoggers < ActiveRecord::Migration
  def change
    create_table :mongo_loggers do |t|

      t.timestamps
    end
  end
end
