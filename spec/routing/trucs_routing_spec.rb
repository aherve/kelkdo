require "rails_helper"

RSpec.describe TrucsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trucs").to route_to("trucs#index")
    end

    it "routes to #new" do
      expect(:get => "/trucs/new").to route_to("trucs#new")
    end

    it "routes to #show" do
      expect(:get => "/trucs/1").to route_to("trucs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trucs/1/edit").to route_to("trucs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trucs").to route_to("trucs#create")
    end

    it "routes to #update" do
      expect(:put => "/trucs/1").to route_to("trucs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trucs/1").to route_to("trucs#destroy", :id => "1")
    end

  end
end
