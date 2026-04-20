# spec/requests/insights_spec.rb
require 'rails_helper'

RSpec.describe "Salary Insights API", type: :request do
  before do
    create(:employee, country: "India", job_title: "Engineer", salary: 50000)
    create(:employee, country: "India", job_title: "Engineer", salary: 70000)
    create(:employee, country: "India", job_title: "Manager", salary: 90000)
  end

  describe "GET /insights/salary_by_country" do
    it "returns min, max, avg salary" do
      get "/insights/salary_by_country", params: { country: "India" }
      json = JSON.parse(response.body)

      expect(json["min_salary"]).to eq(50000)
      expect(json["max_salary"]).to eq(90000)
      expect(json["avg_salary"]).to eq(70000)
    end
  end

  describe "GET /insights/job_title_avg" do
    it "returns avg salary by job title" do
      get "/insights/job_title_avg", params: {
        country: "India",
        job_title: "Engineer"
      }

      json = JSON.parse(response.body)

      expect(json["avg_salary"]).to eq(60000)
    end
  end
end