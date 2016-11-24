require 'rails_helper'

RSpec.describe "runners/index", type: :view do
  before(:each) do
    assign(:runners, [
      Runner.create!(
        :database_id => 2,
        :surname => "Doe1",
        :firstname => "John1",
        :gender => "Gender",
        :school => "Hogwarts",
        :entryclass => "Entryclass",
        :float_time1 => 3.5,
        :classifier1 => "Classifier1",
        :float_time2 => 4.5,
        :total_time => "Total Time",
        :float_total_time => 5.5,
        :day1_score => 6.5,
        :day2_score => 7.5
      ),
      Runner.create!(
        :database_id => 2,
        :surname => "Doe2",
        :firstname => "John2",
        :gender => "Gender",
        :school => "Xavier",
        :entryclass => "Entryclass",
        :float_time1 => 3.5,
        :classifier1 => "Classifier1",
        :float_time2 => 4.5,
        :total_time => "Total Time",
        :float_total_time => 5.5,
        :day1_score => 6.5,
        :day2_score => 7.5
      )
    ])
  end

  it "renders a list of runners" do
    render
    response.should render_template("index")
    expect(response.body).to include("Hogwarts")
    expect(response.body).to include("Xavier")
  end
end
