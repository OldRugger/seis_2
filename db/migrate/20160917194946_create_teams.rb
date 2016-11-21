class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :entryclass
      t.string :JROTC_branch
      t.float :day1_score
      t.float :day2_score
      t.float :total_score
      t.float :sort_score
      t.string :school

      t.timestamps
    end
  end
end
