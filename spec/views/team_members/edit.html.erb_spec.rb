require 'rails_helper'

RSpec.describe "team_members/edit", type: :view do
  before(:each) do
    @team_member = assign(:team_member, TeamMember.create!(
      :team => nil,
      :runner => nil
    ))
  end

  it "renders the edit team_member form" do
    render

    assert_select "form[action=?][method=?]", team_member_path(@team_member), "post" do

      assert_select "input#team_member_team_id[name=?]", "team_member[team_id]"

      assert_select "input#team_member_runner_id[name=?]", "team_member[runner_id]"
    end
  end
end
