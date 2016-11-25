require 'rails_helper'

RSpec.describe TeamResults do
  describe "import results and calculate team scores" do
    let(:dst) {
      Rails.root.join("tmp", "OE0013_two_day_results_day2.csv")
    }
    before(:context) do
      file = File.new(Rails.root.join("testdata", "OE0010_import_test_data.csv"))
      Runner.import(file)
      file = File.new(Rails.root.join("testdata", "seis_teams.csv"))
      Team.import(file)
      src = Rails.root.join("testdata", "OE0013_two_day_results_day2.csv")
      dst = Rails.root.join("tmp", "OE0013_two_day_results_day2.csv")
      file = [dst]
      FileUtils.cp(src, dst)
      expect(File.file?(dst)).to eq(true)
      TeamResults.new.perform(file)
    end

    it "should delete import file" do
      expect(File.file?(dst)).to eq(false)
    end

    it "should calculate team scores" do
      expect(Team.where(name: "Hogwarts Varsity Gold").pluck(:total_score)).to eq([354.08307728257165])
      expect(Team.where(name: "Xavier  Varsity").pluck(:total_score)).to eq([417.7731863299567])
    end

    it "should calculate Average Weighted Times" do
      expect(Day1Awt.where(entryclass: "ISVM").pluck(:awt_float_time)).to eq([56.68888888888889])
      expect(Day2Awt.where(entryclass: "ISVM").pluck(:awt_float_time)).to eq([57.883333333333326])
    end

    it "should use category time in the score calculation for MP" do
      expect(Runner.where(surname: "Doe_206").pluck(:day1_score)).to eq([322.23899775136516])
    end
  end
end
