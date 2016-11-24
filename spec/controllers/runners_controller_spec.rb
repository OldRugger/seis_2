require 'rails_helper'


RSpec.describe RunnersController, type: :controller do

  let(:valid_attributes) { {
      database_id: 4,
      firstname: "test",
      surname: "testsomemore" }
  }

  describe "GET #index" do
    it "assigns all runners as @runners" do
      runner = Runner.create! valid_attributes
      get :index, params: {}
      expect(assigns(:runners)).to eq([runner])
    end
  end


end
