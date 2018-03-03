class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :os_id
      t.integer :device_id

      t.timestamps
    end
  end
end
