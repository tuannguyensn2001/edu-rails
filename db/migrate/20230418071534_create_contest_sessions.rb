class CreateContestSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :contest_sessions do |t|
      t.integer :user_id
      t.integer :test_id
      t.string :session_code
      t.string :status
      t.integer :deadline

      t.timestamps
    end
  end
end
