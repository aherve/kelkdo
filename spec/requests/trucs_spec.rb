require 'rails_helper'

RSpec.describe "Trucs", :type => :request do
  describe "GET /trucs" do
    it "works! (now write some real specs)" do
      get trucs_path
      expect(response).to have_http_status(200)
    end
  end
end
