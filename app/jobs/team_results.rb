class TeamResults 
  include SuckerPunch::Job
  
  def perform(file)
    process_results_file(file[0])
  end

  def process_results_file(file)
    ActiveRecord::Base.transaction do 
      CSV.foreach(file, :headers => true, :col_sep=> ',', :skip_blanks=>true, :row_sep=>:auto ) do |row|
        if ( (row['Database Id'] != nil) &&
             (row['Database Id'].length > 0) && 
             (row['Short'].start_with?('IS')) )    
            process_results_row(row)
        end
      end
    end
    File.delete(file)
  end

  def process_results_row(row)
    puts "update #{row['Database Id'].to_s} #{row['Short']}"
    puts "time1 #{row["Time1"]}"
    if (row["Time1"]) 
      res = get_time(row["Time1"])
      float_time1 = res['float']
      time1 =  res['float']
    else
      float_time1 = 0.0
    end
    puts "time2 #{row["Time2"]}"
    if (row["Time2"]) 
      res = get_time(row["Time2"])
      float_time2 = res['float']
      time2 =  res['float']
    else
      float_time2 = 0.0
    end
    if (row["Total"]) 
      res = get_time(row["Total"])
      float_total = res['float']
      total =  res['float']
    else
      float_total = 0.0
    end
     Runner.where(database_id: row['Database Id'].to_s)
      .update_all(time1: time1, 
                  float_time1: float_time1, 
                  classifier1: row["Classifier1"].to_s,
                  time2: time2, 
                  float_time2: float_time2, 
                  classifier2: row["Classifier2"].to_s,
                  total_time: total,
                  float_total_time: float_total)
  end

  def get_time(time)
    puts "get time #{time}"
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
    puts "float_Time #{float_Time}, #{time}"
    {'float' => float_Time, 'time' => time}
  end
end