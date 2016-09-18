class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :team, index: true
      t.references :runner, index: true

      t.timestamps
    end
  end
end
