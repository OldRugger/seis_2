class Team < ActiveRecord::Base

  def self.import(file)
    teams = 0
    members = 0
    current_team = nil
    CSV.foreach(file.path, headers: true) do |row|
      if row['Team']
        if current_team == nil || current_team.name != row['Team']
          current_team = self.create_team(row)
          teams += 1
        end
        self.assign_member(current_team, row)
        members += 1
      end
    end
    [teams, members]
  end

  private
    def self.create_team(row)
      rowclass = row['Class']
      case rowclass
      when 'ISPM', 'ISPF'
        entryclass = 'ISP'
      when 'ISIM', 'ISIF'
        entryclass = 'ISI'
      when 'ISJVM', 'ISJVF'
        entryclass = 'ISJV'
      when 'ISVM', 'ISVF'
        entryclass = 'ISV'
      end
      Team.create(name: row['Team'],
                  entryclass: entryclass,
                  JROTC_branch: row['Branch'],
                  school: row['School']  )
    end

    def self.assign_member(team, row)
      runner = Runner.where(database_id: row["Database ID"]).first
      if runner
        assign_runner_to_team(team, runner, row)
      else
        raise "error: Runner with database_id #{row["Database ID"]} not found"
      end

    end
    # match name, school and entry class and no other assignment.
    def self.assign_runner_to_team(team, runner, row)
      raise "error: runner already assigned to a team " if TeamMember.where(runner_id: runner.id).first
      raise "error: invalid entry class #{row}" unless runner.entryclass.include? team.entryclass
      raise "error: runner first name does not match #{row}" unless runner.firstname = row['First']
      raise "error: runner last name does not match #{row}" unless runner.surname = row['Last']
      TeamMember.create(team_id: team.id,
                        runner_id: runner.id)
      #
    end

end
