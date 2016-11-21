module ApplicationHelper

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

end
