json.array!(@day2_awts) do |day2_awt|
  json.extract! day2_awt, :id, :runner1_float_time, :runner1_time, :runner1_id, :runner2_float_time, :runner2_time, :runner2_id, :runner3_float_time, :runner3_time, :runner3_id, :awt_float_time, :awt_time, :cat_float_time, :cat_time
  json.url day2_awt_url(day2_awt, format: :json)
end
