class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :code
      t.string :name
      t.integer :time_to_do
      t.integer :time_start
      t.integer :time_end
      t.boolean :do_once
      t.string :password
      t.integer :prevent_cheat
      t.integer :show_mark
      t.integer :show_answer
      t.integer :version
      t.integer :created_by

      t.timestamps
    end
  end
end
