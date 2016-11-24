require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  before(:each) do
    assign(:teams, [
      Team.create!(
        :name => "Hogwarts Varsity",
        :JROTC_branch => "",
        :day1_score => "",
        :day2_score => 2.5,
        :total_score => "",
        :sort_score => "",
        :school => "School"
      ),
      Team.create!(
        :name => "Xavier Varsity",
        :JROTC_branch => "",
        :day1_score => "",
        :day2_score => 2.5,
        :total_score => "",
        :sort_score => "",
        :school => "School"
      )
    ])
  end

  xit "renders a list of teams" do
    render
    response.should render_template("index")
  end
end
