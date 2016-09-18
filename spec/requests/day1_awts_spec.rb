require 'rails_helper'

RSpec.describe "Day1Awts", type: :request do
  describe "GET /day1_awts" do
    it "works! (now write some real specs)" do
      get day1_awts_path
      expect(response).to have_http_status(200)
    end
  end
end
