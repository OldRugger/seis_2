require 'rails_helper'

RSpec.describe "runners/new", type: :view do
  before(:each) do
    assign(:runner, Runner.new(
      :database_id => 1,
      :surname => "MyString",
      :firstname => "MyString",
      :gender => "MyString",
      :school => "MyString",
      :entryclass => "MyString",
      :float_time1 => 1.5,
      :classifier1 => "MyString",
      :float_time2 => 1.5,
      :total_time => "MyString",
      :float_total_time => 1.5,
      :day1_score => 1.5,
      :day2_score => 1.5
    ))
  end

  it "renders new runner form" do
    render

    assert_select "form[action=?][method=?]", runners_path, "post" do

      assert_select "input#runner_database_id[name=?]", "runner[database_id]"

      assert_select "input#runner_surname[name=?]", "runner[surname]"

      assert_select "input#runner_firstname[name=?]", "runner[firstname]"

      assert_select "input#runner_gender[name=?]", "runner[gender]"

      assert_select "input#runner_school[name=?]", "runner[school]"

      assert_select "input#runner_entryclass[name=?]", "runner[entryclass]"

      assert_select "input#runner_float_time1[name=?]", "runner[float_time1]"

      assert_select "input#runner_classifier1[name=?]", "runner[classifier1]"

      assert_select "input#runner_float_time2[name=?]", "runner[float_time2]"

      assert_select "input#runner_total_time[name=?]", "runner[total_time]"

      assert_select "input#runner_float_total_time[name=?]", "runner[float_total_time]"

      assert_select "input#runner_day1_score[name=?]", "runner[day1_score]"

      assert_select "input#runner_day2_score[name=?]", "runner[day2_score]"
    end
  end
end
