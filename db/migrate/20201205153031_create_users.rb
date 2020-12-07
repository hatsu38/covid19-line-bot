class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :line_id, null: false
      t.integer :prefecture_code, null: false
      t.integer :updatable_status_id, null: false, deafult: 0

      t.timestamps
    end
    add_index :users, :line_id, unique: true
  end
end
