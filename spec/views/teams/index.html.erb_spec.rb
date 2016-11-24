require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  xit "renders a list of teams" do
    file = File.new(Rails.root.join("testdata", "OE0010_import_test_data.csv"))
    Runner.import(file)
    file = File.new(Rails.root.join("testdata", "seis_teams.csv"))
    Team.import(file)
    render
    response.should render_template("index")
    expect(response.body).to include("Hogwarts Varsity Gold (354.08)")
    expect(response.body).to include("Xavier Varsity (417.77)")
    expect(response.body).to include("Bel-Air JV (600.37)")
    expect(response.body).to include("Beacon Town 4")
  end
end
