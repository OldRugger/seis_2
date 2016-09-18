require 'rails_helper'

RSpec.describe "teams/show", type: :view do
  before(:each) do
    @team = assign(:team, Team.create!(
      :team_name => "",
      :category => "",
      :JROTC_branch => "",
      :day1_score => "",
      :day2_score => 2.5,
      :total_score => "",
      :sort_score => "",
      :school => "School"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/School/)
  end
end
