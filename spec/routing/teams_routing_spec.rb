require "rails_helper"

RSpec.describe TeamsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/teams").to route_to("teams#index")
    end

  end
end
