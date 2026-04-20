# spec/requests/insights_spec.rb
require 'rails_helper'

RSpec.describe "Salary Insights API", type: :request do
  before do
    create(:employee, country: "India", job_title: "Engineer", salary: 50000)
    create(:employee, country: "India", job_title: "Engineer", salary: 70000)
    create(:employee, country: "India", job_title: "Manager", salary: 90000)
  end

  describe "GET /insights/country" do
    it "returns min, max, avg salary" do
      get "/insights/country", params: { country: "India" }
      json = JSON.parse(response.body)

      expect(json["min"]).to eq(50000)
      expect(json["max"]).to eq(90000)
      expect(json["avg"]).to eq(70000)
    end
  end
end