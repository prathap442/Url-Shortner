class CreateUserLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_links do |t|
      t.integer :user_id
      t.integer :link_id
      t.timestamps
    end
  end
end
