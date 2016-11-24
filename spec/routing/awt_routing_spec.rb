require "rails_helper"

RSpec.describe RunnersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/awt").to route_to("awt#index")
    end

  end
end
