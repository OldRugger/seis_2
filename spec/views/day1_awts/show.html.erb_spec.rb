require 'rails_helper'

RSpec.describe "day1_awts/show", type: :view do
  before(:each) do
    @day1_awt = assign(:day1_awt, Day1Awt.create!(
      :runner1_float_time => 2.5,
      :runner1_id => 3,
      :runner2_float_time => 4.5,
      :runner2_id => 5,
      :runner3_float_time => 6.5,
      :runner3_id => 7,
      :awt_float_time => 8.5,
      :cat_float_time => 9.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/9.5/)
  end
end
