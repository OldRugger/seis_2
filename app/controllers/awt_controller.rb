class AwtController < ApplicationController
  def index
    @class_list = CLASS_LIST
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
