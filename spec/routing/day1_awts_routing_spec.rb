require "rails_helper"

RSpec.describe Day1AwtsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/day1_awts").to route_to("day1_awts#index")
    end

    it "routes to #new" do
      expect(:get => "/day1_awts/new").to route_to("day1_awts#new")
    end

    it "routes to #show" do
      expect(:get => "/day1_awts/1").to route_to("day1_awts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/day1_awts/1/edit").to route_to("day1_awts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/day1_awts").to route_to("day1_awts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/day1_awts/1").to route_to("day1_awts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/day1_awts/1").to route_to("day1_awts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/day1_awts/1").to route_to("day1_awts#destroy", :id => "1")
    end

  end
end
