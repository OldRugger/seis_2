require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  # let(:time) {
  #   if  ActiveRecord::Base.connection.adapter_name === "SQLite"
  #     return 65.65
  #   else
  #     return "1:05:39"
  #   end
  # }
  describe "#float_float_time_to_hhmmss" do
    it "returns time in hhmmss" do
      helper.float_time_to_hhmmss(65.65).should eq( "1:05:39")
    end
    it "should handle null" do
      helper.float_time_to_hhmmss(nil).should eq("")
    end
  end

  describe "#is_sqlite?" do
    it "should return true if the datbase is sqlite" do
      test = ActiveRecord::Base.connection.adapter_name === "SQLite"
      helper.is_sqlite?.should eq(test)
    end
  end

  describe "#time_to_value" do
    before(:each) do
      if  ActiveRecord::Base.connection.adapter_name === "SQLite"
        @time = 65.65
      else
        @time = "1:05:39"
      end
    end

    it "should return OT" do
      helper.time_to_value("5", @time, @time).should eq("OT")
    end
    it "should return DSQ" do
      helper.time_to_value("4", @time, @time).should eq("DSQ")
    end
    it "should return MP" do
      helper.time_to_value("3", @time, @time).should eq("MP")
    end
    it "should return DNF" do
      helper.time_to_value("2", @time, @time).should eq("DNF")
    end
    it "should return DNS" do
      helper.time_to_value("1", @time, @time).should eq("DNS")
    end
    it "should return time" do
      helper.time_to_value("0", @time, @time).should eq("1:05:39")
    end
  end

end
