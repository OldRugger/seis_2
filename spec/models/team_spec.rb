require 'rails_helper'

RSpec.describe Team, type: :model do
  it "should import teams " do
    file = File.new(Rails.root.join("testdata", "OE0010_import_test_data.csv"))
    Runner.import(file)
    file = File.new(Rails.root.join("testdata", "seis_teams.csv"))
    Team.import(file)
    expect(Team.all.count).to eq(38)
    expect(TeamMember.all.count).to eq(163)
  end
end
