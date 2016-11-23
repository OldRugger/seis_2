class TeamResults
  include SuckerPunch::Job

  def perform(file)
    process_results_file(file[0])
    calculate_awt
  end

  def calculate_awt
    ActiveRecord::Base.transaction do
      puts "calculate_awt"
      delete_awt_results
      calculate_awt_by_class("ISP")
      calculate_awt_by_class("ISI")
      calculate_awt_by_class("ISJV")
      calculate_awt_by_class("ISV")
      update_team_scores
    end
  end

  def update_team_scores
    sortvalue = 9999.0
    teams = Team.all
    teams.each do |team|
      day1_score = get_team_day_scores(team, 1)
      day2_score = get_team_day_scores(team, 2)
      team.total_score = day1_score + day2_score
      team.day1_score  = day1_score > 0.0 ? day1_score : sortvalue
      team.day2_score  = day2_score > 0.0 ? day2_score : sortvalue
      team.sort_score  = team.day1_score + team.day2_score
      team.save
    end
  end

  def get_team_day_scores(team, day)
    day_score = 0.0
    scores = TeamMember.joins(:runner)
      .select("team_members.team_id,runners.id as runner_id,runners.day#{day}_score as day_score")
      .where(team_id: team.id).where("runners.day#{day}_score > ?", 0.0)
      .order("runners.day#{day}_score")
      .limit(3)
    if scores.count === 3
      scores.each do |score|
        day_score += score.day_score if score.day_score
      end
    end
    day_score
  end

  def calculate_awt_by_class(team_class)
    puts "calculate_awt - #{team_class}"
    #day 1
    awtm1 = calculate_awt_by_class_gender(team_class, "M", 1)
    awtf1 = calculate_awt_by_class_gender(team_class, "F", 1)
    cat_time1 = get_category_time(awtm1, awtf1)
    update_day_awt(awtm1, team_class, "M", 1, cat_time1) if awtm1
    update_day_awt(awtf1, team_class, "F", 1, cat_time1) if awtf1
    #day 2
    awtm2 = calculate_awt_by_class_gender(team_class, "M", 2)
    awtf2 = calculate_awt_by_class_gender(team_class, "F", 2)
    cat_time2 = get_category_time(awtm2, awtf2)
    update_day_awt(awtm2, team_class, "M", 2, cat_time2) if awtm2
    update_day_awt(awtf2, team_class, "F", 2, cat_time2) if awtf2
    update_day_scores(awtm1, awtm2, cat_time1, cat_time2, team_class, "M")
    update_day_scores(awtf1, awtf2, cat_time1, cat_time2, team_class, "F")
  end

  def delete_awt_results
    Day1Awt.delete_all
    Day2Awt.delete_all
  end

  def update_day_awt(awt, team_class, gender, day, cat_time)
    klass = "Day#{day}Awt".constantize
    klass.create do |a|
      a.entryclass          = team_class + gender
      a.runner1_id          =  awt[:runners][0][:id]
      a.runner1_float_time  =  awt[:runners][0]["float_time#{day}".to_sym]
      a.runner1_time        =  awt[:runners][0]["time#{day}".to_sym]
      a.runner2_id          =  awt[:runners][1][:id]
      a.runner2_float_time  =  awt[:runners][1]["float_time#{day}".to_sym]
      a.runner2_time        =  awt[:runners][1]["time#{day}".to_sym]
      a.runner3_id          =  awt[:runners][2][:id]
      a.runner3_float_time  =  awt[:runners][2]["float_time#{day}".to_sym]
      a.runner3_time        =  awt[:runners][2]["time#{day}".to_sym]
      a.cat_float_time      =  cat_time
      a.awt_float_time      =  awt[:awt]
    end
  end

  def update_day_scores(awt1, awt2, cat_time1, cat_time2, team_class, gender)
    runners = Runner.where(entryclass: team_class+gender)
    runners.each do |r|
      if (r.classifier1 === "0" && r.float_time1 > 0 && awt1)
        if r.float_time1 < APP_CONFIG[:max_time]
          r.day1_score = 60 * (r.float_time1/awt1[:awt])
        else
          r.day1_score = 10 + (60 * (APP_CONFIG[:max_time]/cat_time1))
        end
      end
      if (r.classifier2 === "0" && r.float_time2 > 0 && awt2)
        if r.float_time2 < APP_CONFIG[:max_time]
          r.day2_score = 60 * (r.float_time2/awt2[:awt])
        else
          r.day2_score = 10 + (60 * (APP_CONFIG[:max_time]/cat_time2))
        end
      end
      if (awt1 || awt2)
        r.save
      end
    end
  end

  def get_category_time(m_awt, f_awt)
    m = 0
    f = 0
    m = m_awt[:awt] if m_awt
    f = f_awt[:awt] if f_awt
    cat_time = m < f  ? m : f
  end

  def calculate_awt_by_class_gender(team_class, gender, day)
    puts "calculate_awt - #{team_class} - #{gender}"
    times = []
    awt_runners = Runner.where(entryclass: team_class+gender)
                    .where("classifier#{day} = 0 and ? > 0", "float_time#{day}")
                      .order("float_time#{day}").limit(3)
    return nil if awt_runners.count == 0
    awt_runners.each { |r| times.push(r.send("float_time#{day}")) }
    awt = get_awt_time(times)
    {runners: awt_runners, awt: awt}
  end

  def get_awt_time(times)
    times.inject(0.0) { |sum, el| sum + el } / times.size
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
    if (row["Time1"])
      res = get_time(row["Time1"])
      float_time1 = res['float']
      time1 =  res['float']
    else
      float_time1 = 0.0
    end
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
    {'float' => float_Time, 'time' => time}
  end

end