json.array!(@day1_awts) do |day1_awt|
  json.extract! day1_awt, :id, :runner1_float_time, :runner1_time, :runner1_id, :runner2_float_time, :runner2_time, :runner2_id, :runner3_float_time, :runner3_time, :runner3_id, :awt_float_time, :awt_time, :cat_float_time, :cat_time
  json.url day1_awt_url(day1_awt, format: :json)
end
