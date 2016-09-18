require 'rails_helper'

RSpec.describe "Day2Awts", type: :request do
  describe "GET /day2_awts" do
    it "works! (now write some real specs)" do
      get day2_awts_path
      expect(response).to have_http_status(200)
    end
  end
end
