require "rails_helper"

RSpec.describe RunnersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/").to route_to("home#index")
    end

    it "bad path routes to #index" do
      expect(:get => "/bad_path").to route_to("home#index", :path => "bad_path")
    end

  end
end
