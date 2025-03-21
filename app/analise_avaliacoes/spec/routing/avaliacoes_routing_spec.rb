require "rails_helper"

RSpec.describe AvaliacoesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/avaliacoes").to route_to("avaliacoes#index")
    end

    it "routes to #new" do
      expect(get: "/avaliacoes/new").to route_to("avaliacoes#new")
    end

    it "routes to #show" do
      expect(get: "/avaliacoes/1").to route_to("avaliacoes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/avaliacoes/1/edit").to route_to("avaliacoes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/avaliacoes").to route_to("avaliacoes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/avaliacoes/1").to route_to("avaliacoes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/avaliacoes/1").to route_to("avaliacoes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/avaliacoes/1").to route_to("avaliacoes#destroy", id: "1")
    end
  end
end
