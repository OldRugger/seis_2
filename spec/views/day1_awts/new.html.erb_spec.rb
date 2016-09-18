require 'rails_helper'

RSpec.describe "day1_awts/new", type: :view do
  before(:each) do
    assign(:day1_awt, Day1Awt.new(
      :runner1_float_time => 1.5,
      :runner1_id => 1,
      :runner2_float_time => 1.5,
      :runner2_id => 1,
      :runner3_float_time => 1.5,
      :runner3_id => 1,
      :awt_float_time => 1.5,
      :cat_float_time => 1.5
    ))
  end

  it "renders new day1_awt form" do
    render

    assert_select "form[action=?][method=?]", day1_awts_path, "post" do

      assert_select "input#day1_awt_runner1_float_time[name=?]", "day1_awt[runner1_float_time]"

      assert_select "input#day1_awt_runner1_id[name=?]", "day1_awt[runner1_id]"

      assert_select "input#day1_awt_runner2_float_time[name=?]", "day1_awt[runner2_float_time]"

      assert_select "input#day1_awt_runner2_id[name=?]", "day1_awt[runner2_id]"

      assert_select "input#day1_awt_runner3_float_time[name=?]", "day1_awt[runner3_float_time]"

      assert_select "input#day1_awt_runner3_id[name=?]", "day1_awt[runner3_id]"

      assert_select "input#day1_awt_awt_float_time[name=?]", "day1_awt[awt_float_time]"

      assert_select "input#day1_awt_cat_float_time[name=?]", "day1_awt[cat_float_time]"
    end
  end
end
