require 'rails_helper'

RSpec.describe TablesController, type: :controller do

  describe "GET #all_tables" do
    it "returns http success" do
      get :all_tables
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #table" do
    it "returns http success" do
      get :table
      expect(response).to have_http_status(:success)
    end
  end

end
