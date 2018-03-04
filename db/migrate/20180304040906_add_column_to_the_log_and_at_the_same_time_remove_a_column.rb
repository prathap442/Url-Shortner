class AddColumnToTheLogAndAtTheSameTimeRemoveAColumn < ActiveRecord::Migration[5.1]
  def change
  	remove_column :logs,:os_id,:integer
  	add_column :logs,:operating_system_id,:integer
    add_column :logs,:browser,:string
    add_column :logs,:link_id,:integer
  end
end
