class CreateTestMultipleChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :test_multiple_choices do |t|
      t.string :file_path
      t.float :score
      t.timestamps
    end
  end
end
