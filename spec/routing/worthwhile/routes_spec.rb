require "spec_helper"

module Worthwhile
  describe "routing" do
    

    describe "Classify concerns" do
      routes { Worthwhile::Engine.routes }
      it "routes to #new" do
        expect(new_classify_concern_path).to eq '/classify_concerns/new'
        get("/classify_concerns/new").should route_to("worthwhile/classify_concerns#new")
      end
    end

    describe "generic work" do
      routes { Rails.application.routes }
      it 'routes to #new' do
        expect(new_curation_concern_generic_work_path).to eq '/concern/generic_works/new'
        get("/concern/generic_works/new").should route_to("curation_concern/generic_works#new")
      end
    end
  end
end
