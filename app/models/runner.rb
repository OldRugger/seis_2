class Runner < ActiveRecord::Base
  def self.import(file)
    added = 0
    skipped = 0
    self.clear_existing_data
    CSV.foreach(file.path, headers: true) do |row|
      if row["Short"].include? "IS"
        Runner.create(database_id: row["Database Id"],
                      surname: row["Surname"].gsub("'"){"\\'"},
                      firstname: row["First name"].gsub("'"){"\\'"},
                      school: row["City"].gsub("'"){"\\'"},
                      entryclass: row["Short"],
                      gender: row['S'])
        added += 1
      else
        skipped += 1
      end
    end
    [added, skipped]
  end

  private

  def self.clear_existing_data
    TeamMember.delete_all
    Team.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all
    Runner.delete_all
  end

end
