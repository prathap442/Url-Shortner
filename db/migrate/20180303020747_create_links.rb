class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :link_name
      t.string :encoded_link
      t.integer :link_click_count
      t.timestamps
    end
  end
end
