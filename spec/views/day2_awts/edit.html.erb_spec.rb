require 'rails_helper'

RSpec.describe "day2_awts/edit", type: :view do
  before(:each) do
    @day2_awt = assign(:day2_awt, Day2Awt.create!(
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

  it "renders the edit day2_awt form" do
    render

    assert_select "form[action=?][method=?]", day2_awt_path(@day2_awt), "post" do

      assert_select "input#day2_awt_runner1_float_time[name=?]", "day2_awt[runner1_float_time]"

      assert_select "input#day2_awt_runner1_id[name=?]", "day2_awt[runner1_id]"

      assert_select "input#day2_awt_runner2_float_time[name=?]", "day2_awt[runner2_float_time]"

      assert_select "input#day2_awt_runner2_id[name=?]", "day2_awt[runner2_id]"

      assert_select "input#day2_awt_runner3_float_time[name=?]", "day2_awt[runner3_float_time]"

      assert_select "input#day2_awt_runner3_id[name=?]", "day2_awt[runner3_id]"

      assert_select "input#day2_awt_awt_float_time[name=?]", "day2_awt[awt_float_time]"

      assert_select "input#day2_awt_cat_float_time[name=?]", "day2_awt[cat_float_time]"
    end
  end
end
