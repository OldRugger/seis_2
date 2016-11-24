require 'rails_helper'

RSpec.describe "teams/show", type: :view do
  before(:each) do
    @team = assign(:team, Team.create!(
      :name => "Hogwarts Varsity",
      :school => "Hogwarts"
    ))
  end

  xit "renders attributes in <p>" do
    render
    response.should render_template("show")
    expect(rendered).to match(/Hogwarts Varsity/)
    expect(rendered).to match(/Hogwarts/)
  end
end
