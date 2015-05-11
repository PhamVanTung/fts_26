class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :category_id
      t.integer :user_id
      t.datetime :start_time
      t.integer :status
      t.integer :score

      t.timestamps null: false
    end
  end
end
