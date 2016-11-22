module ApplicationHelper

  CLASS_LIST =  ['ISVM', 'ISVF', 'ISJVM', 'ISJVF', 'ISIM', 'ISIF', 'ISPM', 'ISPF']

  def float_time_to_hhmmss(float_time)
    if (float_time && float_time > 0)
      min = float_time.floor
      mm = (min % 60).floor
      hh = (min / 60).floor
      ss = ((float_time - min) * 60).floor
      hhmmss = "#{hh.to_s}:#{format('%02d', mm)}:#{format('%02d', ss)}"
    else
      hhmmss = "00:00:00"
    end
  end

  def is_sqlite?
  	ActiveRecord::Base.connection.adapter_name === "SQLite"
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

end
