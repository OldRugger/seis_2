require 'rails_helper'


RSpec.describe TeamsController, type: :controller do

  let(:valid_attributes) { {
      name: "Xavier JV",
      entryclass: "ISJV",
      JROTC_branch: "Navy",
    }
  }

  describe "GET #index" do
    it "assigns all teams as @teams" do
      team = Team.create! valid_attributes
      get :index, params: {}
      expect(assigns.keys.include?("isjv")).to be true
      expect(assigns(:isjv)).to eq([team])
      expect(assigns.keys.include?("day1_hash")).to be true
      expect(assigns.keys.include?("day2_hash")).to be true
      expect(assigns.keys.include?("isi")).to be true
      expect(assigns.keys.include?("isp")).to be true
      expect(assigns.keys.include?("isv")).to be true
      expect(assigns.keys.include?("jrotc")).to be true
      expect(assigns.keys.include?("classes")).to be true
      expect(assigns.keys.include?("class_list")).to be true
    end
  end
end
