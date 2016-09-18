require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  before(:each) do
    assign(:teams, [
      Team.create!(
        :team_name => "",
        :category => "",
        :JROTC_branch => "",
        :day1_score => "",
        :day2_score => 2.5,
        :total_score => "",
        :sort_score => "",
        :school => "School"
      ),
      Team.create!(
        :team_name => "",
        :category => "",
        :JROTC_branch => "",
        :day1_score => "",
        :day2_score => 2.5,
        :total_score => "",
        :sort_score => "",
        :school => "School"
      )
    ])
  end

  it "renders a list of teams" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
  end
end
