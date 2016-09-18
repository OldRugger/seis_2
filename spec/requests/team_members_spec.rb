require 'rails_helper'

RSpec.describe "TeamMembers", type: :request do
  describe "GET /team_members" do
    it "works! (now write some real specs)" do
      get team_members_path
      expect(response).to have_http_status(200)
    end
  end
end
