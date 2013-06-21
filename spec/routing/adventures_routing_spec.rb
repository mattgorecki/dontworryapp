require "spec_helper"

describe AdventuresController do
  describe "routing" do

    it "routes to #index" do
      get("/adventures").should route_to("adventures#index")
    end

    it "routes to #new" do
      get("/adventures/new").should route_to("adventures#new")
    end

    it "routes to #show" do
      get("/adventures/1").should route_to("adventures#show", :id => "1")
    end

    it "routes to #edit" do
      get("/adventures/1/edit").should route_to("adventures#edit", :id => "1")
    end

    it "routes to #create" do
      post("/adventures").should route_to("adventures#create")
    end

    it "routes to #update" do
      put("/adventures/1").should route_to("adventures#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/adventures/1").should route_to("adventures#destroy", :id => "1")
    end

  end
end
