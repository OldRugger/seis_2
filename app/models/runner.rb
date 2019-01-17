class Runner < ActiveRecord::Base
  def self.import(file)
    added = 0
    skipped = 0
    self.clear_existing_data
    CSV.foreach(file.path, headers: true) do |row|
      puts [row]
      if row["Short"] && (row["Short"].include? "IS")
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

  def self.import_results_row(row)
    if (row["Time2"])
      res = self.get_float_time(row["Time2"])
      float_time1 = res['float']
      time1 =  res['time']
    else
      float_time1 = 0.0
    end
    if (row["Time3"])
      res = self.get_float_time(row["Time3"])
      float_time2 = res['float']
      time2 =  res['time']
    else
      float_time2 = 0.0
    end
    if (row["Total"])
      res = self.get_float_time(row["Total"])
      float_total = res['float']
      total =  res['time']
    else
      float_total = 0.0
    end
    Runner.where(database_id: row['Database Id'].to_s)
      .update_all(time1: time1,
                  float_time1: float_time1,
                  classifier1: row["Classifier2"].to_s,
                  time2: time2,
                  float_time2: float_time2,
                  classifier2: row["Classifier3"].to_s,
                  total_time: total,
                  float_total_time: float_total)

  end

  private

  def self.clear_existing_data
    TeamMember.delete_all
    Team.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all
    Runner.delete_all
  end

  def self.get_float_time(time)
    float_time = 0.0
    hhmmss = time.split(":")
    if (hhmmss.length ==3 ) then
      time = time
      hh = hhmmss[0].to_i
      mm = hhmmss[1].to_i
      ss = hhmmss[2].to_i
      float_Time = (hh*60) + mm + (ss/60.0)
    elsif (hhmmss.length == 2) then
      time = "00:" + time
      mm = hhmmss[0].to_i
      ss = hhmmss[1].to_i
      float_Time = mm + (ss/60.0)
    end
    {'float' => float_Time, 'time' => time}
  end

end
