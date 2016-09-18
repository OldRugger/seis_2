require "rails_helper"

RSpec.describe Day2AwtsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/day2_awts").to route_to("day2_awts#index")
    end

    it "routes to #new" do
      expect(:get => "/day2_awts/new").to route_to("day2_awts#new")
    end

    it "routes to #show" do
      expect(:get => "/day2_awts/1").to route_to("day2_awts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/day2_awts/1/edit").to route_to("day2_awts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/day2_awts").to route_to("day2_awts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/day2_awts/1").to route_to("day2_awts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/day2_awts/1").to route_to("day2_awts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/day2_awts/1").to route_to("day2_awts#destroy", :id => "1")
    end

  end
end
