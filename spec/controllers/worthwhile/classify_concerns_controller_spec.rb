require 'spec_helper'

describe Worthwhile::ClassifyConcernsController do
  routes { Worthwhile::Engine.routes }
  let(:user) { FactoryGirl.create(:user) }

  describe '#new' do
    it 'requires authentication' do
      get :new
      expect(response).to redirect_to(main_app.user_session_path)
    end
    it 'renders when signed in' do
      sign_in(user)
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create' do
    it 'redirect to login page if user is not logged in' do
      post :create, classify: { curation_concern_type: 'GenericWork' }
      expect(response).to redirect_to(main_app.user_session_path)
    end

    it 'requires authentication' do
      sign_in(user)
      # Had to stub the actual handling of curation_concern paths since those paths live outside the engine while the path to this controller lives inside the engine.
      new_curation_concern_generic_work_path = "/stub/path"
      subject.should_receive(:new_polymorphic_path).with([:curation_concern, GenericWork]).and_return(new_curation_concern_generic_work_path)
      post :create, classify_concern: { curation_concern_type: 'GenericWork' }
      expect(response).to redirect_to(new_curation_concern_generic_work_path)
    end

  end
end
