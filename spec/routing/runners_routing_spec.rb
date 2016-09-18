require "rails_helper"

RSpec.describe RunnersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/runners").to route_to("runners#index")
    end

    it "routes to #new" do
      expect(:get => "/runners/new").to route_to("runners#new")
    end

    it "routes to #show" do
      expect(:get => "/runners/1").to route_to("runners#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/runners/1/edit").to route_to("runners#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/runners").to route_to("runners#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/runners/1").to route_to("runners#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/runners/1").to route_to("runners#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/runners/1").to route_to("runners#destroy", :id => "1")
    end

  end
end
