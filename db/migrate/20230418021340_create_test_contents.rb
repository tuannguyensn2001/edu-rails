class CreateTestContents < ActiveRecord::Migration[7.0]
  def change
    create_table :test_contents do |t|
      t.integer :test_id
      t.references :testable, polymorphic: true, null: false, foreign_key: false

      t.timestamps
    end
  end
end
