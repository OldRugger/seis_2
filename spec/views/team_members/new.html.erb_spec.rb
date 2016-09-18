require 'rails_helper'

RSpec.describe "team_members/new", type: :view do
  before(:each) do
    assign(:team_member, TeamMember.new(
      :team => nil,
      :runner => nil
    ))
  end

  it "renders new team_member form" do
    render

    assert_select "form[action=?][method=?]", team_members_path, "post" do

      assert_select "input#team_member_team_id[name=?]", "team_member[team_id]"

      assert_select "input#team_member_runner_id[name=?]", "team_member[runner_id]"
    end
  end
end
