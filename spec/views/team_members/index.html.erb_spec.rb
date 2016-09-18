require 'rails_helper'

RSpec.describe "team_members/index", type: :view do
  before(:each) do
    assign(:team_members, [
      TeamMember.create!(
        :team => nil,
        :runner => nil
      ),
      TeamMember.create!(
        :team => nil,
        :runner => nil
      )
    ])
  end

  it "renders a list of team_members" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
