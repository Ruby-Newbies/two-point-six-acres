class CreateUsermails < ActiveRecord::Migration
  def change
    create_table :usermails do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :content
      t.integer :status
      t.timestamps null: false
    end
  end
end
