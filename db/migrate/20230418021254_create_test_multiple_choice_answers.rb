class CreateTestMultipleChoiceAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :test_multiple_choice_answers do |t|

      t.integer :test_multiple_choice_id
      t.string :answer
      t.float :score
      t.integer :type

      t.timestamps
    end
  end
end
