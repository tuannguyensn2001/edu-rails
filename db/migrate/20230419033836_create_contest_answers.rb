class CreateContestAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :contest_answers do |t|
      t.integer :session_id
      t.string :question_id
      t.string :integer
      t.string :answer

      t.timestamps
    end
  end
end
