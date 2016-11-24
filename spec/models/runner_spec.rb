require 'rails_helper'

RSpec.describe Runner, type: :model do

  it "should import runners " do
    file = File.new(Rails.root.join("testdata", "OE0010_import_test_data.csv"))
    Runner.import(file)
    expect(Runner.all.count).to eq(180)
  end

end
