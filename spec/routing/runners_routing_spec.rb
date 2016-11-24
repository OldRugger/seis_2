require "rails_helper"

RSpec.describe RunnersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/runners").to route_to("runners#index")
    end

    it "routes to #import" do
      expect(:post => "/runners/import").to route_to("runners#import")
    end

  end
end
