module ApplicationHelper

  CLASS_LIST =  ['ISVM', 'ISVF', 'ISJVM', 'ISJVF', 'ISIM', 'ISIF', 'ISPM', 'ISPF']

  def float_time_to_hhmmss(float_time)
    if (float_time && float_time > 0)
      min = float_time.floor
      mm = (min % 60).floor
      hh = (min / 60).floor
      ss = ((float_time - min) * 60).round
      hhmmss = "#{hh.to_s}:#{format('%02d', mm)}:#{format('%02d', ss)}"
    else
      hhmmss = ""
    end
  end

  def get_float_time(time)
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

  def is_sqlite?
  	ActiveRecord::Base.connection.adapter_name === "SQLite"
  end

  def time_to_value(classifier, time)
    return 'OT'  if classifier === '5'  # Over Time
    return 'DSQ' if classifier === '4'  # disqualified
    return 'MP'  if classifier === '3'  # Missed Punch
    return 'DNF' if classifier === '2'  # Did not finish
    return 'DNS' if classifier === '1'  # Did not start
    time = is_sqlite? ? float_time_to_hhmmss(time) : time
  end

  def get_awt_hash
    day1_awts = Day1Awt.all
    day1_hash = Hash.new
    day1_awts.each do |awt|
      day1_hash[awt.entryclass] = {awt: float_time_to_hhmmss(awt.awt_float_time),
                                   cat: float_time_to_hhmmss(awt.cat_float_time) }
    end

    day2_awts = Day2Awt.all
    day2_hash = Hash.new
    day2_awts.each do |awt|
      day2_hash[awt.entryclass] = {awt: float_time_to_hhmmss(awt.awt_float_time),
                                    cat: float_time_to_hhmmss(awt.cat_float_time) }
    end
    {day1: day1_hash, day2: day2_hash}
  end

  def get_awt_with_runners
    @awt = Hash.new
    2.times do |n|
      day = n + 1
      @awt[day] = Hash.new
      klass = "Day#{day}Awt".constantize
      awt = klass.all
      awt.each do |result|
        @awt[day][result.entryclass] = float_time_to_hhmmss(result.awt_float_time)
        @awt[day]["#{result.entryclass}_cat"] = float_time_to_hhmmss(result.cat_float_time)
        get_runners(day, result)
      end
    end
    @awt
  end

  private

  def get_runners (day, result)
    3.times do |n|
      r = n + 1
      if result.send("runner#{r}_float_time") == 0
        time = "n/a*"
      elsif is_sqlite?
        time = float_time_to_hhmmss(result.send("runner#{r}_time"))
      else
        time = result.send("runner#{r}_time")
      end
      @awt[day]["#{result.entryclass}#{r}"] = time
    end
  end

end
