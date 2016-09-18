require 'rails_helper'

RSpec.describe "day2_awts/index", type: :view do
  before(:each) do
    assign(:day2_awts, [
      Day2Awt.create!(
        :runner1_float_time => 2.5,
        :runner1_id => 3,
        :runner2_float_time => 4.5,
        :runner2_id => 5,
        :runner3_float_time => 6.5,
        :runner3_id => 7,
        :awt_float_time => 8.5,
        :cat_float_time => 9.5
      ),
      Day2Awt.create!(
        :runner1_float_time => 2.5,
        :runner1_id => 3,
        :runner2_float_time => 4.5,
        :runner2_id => 5,
        :runner3_float_time => 6.5,
        :runner3_id => 7,
        :awt_float_time => 8.5,
        :cat_float_time => 9.5
      )
    ])
  end

  it "renders a list of day2_awts" do
    render
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
  end
end
