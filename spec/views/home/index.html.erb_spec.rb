require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "renders a list of links" do
    render
    response.should render_template("index")
    expect(response.body).to include("Import Runners / Teams")
    expect(response.body).to include("Team Results")
    expect(response.body).to include("Team Results 2 (for publishing)")
    expect(response.body).to include("Individual Awards (based on AWT)")
    expect(response.body).to include("Average Weighted Time")
  end
end
