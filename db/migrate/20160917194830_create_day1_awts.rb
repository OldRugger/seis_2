class CreateDay1Awts < ActiveRecord::Migration
  def change
    create_table :day1_awts do |t|
      t.string :entryclass
      t.float :runner1_float_time
      t.time :runner1_time
      t.integer :runner1_id
      t.float :runner2_float_time
      t.time :runner2_time
      t.integer :runner2_id
      t.float :runner3_float_time
      t.time :runner3_time
      t.integer :runner3_id
      t.float :awt_float_time
      t.time :awt_time
      t.float :cat_float_time
      t.time :cat_time

      t.timestamps
    end
  end
end
