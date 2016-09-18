require 'rails_helper'

RSpec.describe "teams/new", type: :view do
  before(:each) do
    assign(:team, Team.new(
      :team_name => "",
      :category => "",
      :JROTC_branch => "",
      :day1_score => "",
      :day2_score => 1.5,
      :total_score => "",
      :sort_score => "",
      :school => "MyString"
    ))
  end

  it "renders new team form" do
    render

    assert_select "form[action=?][method=?]", teams_path, "post" do

      assert_select "input#team_team_name[name=?]", "team[team_name]"

      assert_select "input#team_category[name=?]", "team[category]"

      assert_select "input#team_JROTC_branch[name=?]", "team[JROTC_branch]"

      assert_select "input#team_day1_score[name=?]", "team[day1_score]"

      assert_select "input#team_day2_score[name=?]", "team[day2_score]"

      assert_select "input#team_total_score[name=?]", "team[total_score]"

      assert_select "input#team_sort_score[name=?]", "team[sort_score]"

      assert_select "input#team_school[name=?]", "team[school]"
    end
  end
end
