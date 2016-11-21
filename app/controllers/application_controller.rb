class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def float_time_to_hhmmss(float_time)
  #   if (float_time > 0)
  #     min = float_time.floor 
  #     mm = (min % 60).floor
  #     hh = (min / 60).floor
  #     ss = ((float_time - min) * 60).floor
  #     hhmmss = hh.to_s + ":" + mm.to_s + ":" + ss.to_s
  #   else
  #     hhmmss = "00:00:00"
  #   end
  # end

  # def is_sqlite?
  # 	ActiveRecord::Base.connection.adapter_name === "SQLite"
  # end

end
