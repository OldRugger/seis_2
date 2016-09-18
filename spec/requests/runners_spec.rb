require 'rails_helper'

RSpec.describe "Runners", type: :request do
  describe "GET /runners" do
    it "works! (now write some real specs)" do
      get runners_path
      expect(response).to have_http_status(200)
    end
  end
end
