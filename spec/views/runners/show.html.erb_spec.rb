require 'rails_helper'

RSpec.describe "runners/show", type: :view do
  before(:each) do
    @runner = assign(:runner, Runner.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/School/)
    expect(rendered).to match(/Entryclass/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Classifier1/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/Total Time/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
  end
end
