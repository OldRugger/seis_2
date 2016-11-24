require 'rails_helper'

RSpec.describe AwtController, type: :controller do

  describe "GET #index" do
    it "gets awt lists" do
      get :index, params: {}
      expect(response).to have_http_status(:success)
      expect(assigns.keys.include?("class_list")).to be true
      expect(assigns.keys.include?("awt")).to be true
    end
  end

end
