require 'rails_helper'

RSpec.describe "runners/index", type: :view do
  before(:each) do
    assign(:runners, [
      Runner.create!(
        :database_id => 2,
        :surname => "Surname",
        :firstname => "Firstname",
        :gender => "Gender",
        :school => "School",
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
        :surname => "Surname",
        :firstname => "Firstname",
        :gender => "Gender",
        :school => "School",
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
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
    assert_select "tr>td", :text => "Entryclass".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Classifier1".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => "Total Time".to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
  end
end
