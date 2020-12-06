class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :line_id, null: false
      t.integer :prefecture_code, null: false

      t.timestamps
    end
  end
end