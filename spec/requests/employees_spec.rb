# spec/requests/employees_spec.rb
require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  describe "GET /employees" do
    it "returns employees list" do
      create_list(:employee, 3)

      get "/employees"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end

    it "supports pagination" do
      get "/employees", params: { page: 1, per_page: 2 }

      json = JSON.parse(response.body)
      expect(json["data"].length).to eq(2)
    end

    it "filters by country" do
      create(:employee, country: "USA")

      get "/employees", params: { country: "India" }

      json = JSON.parse(response.body)
      expect(json["data"].all? { |e| e["country"] == "India" }).to be true
    end

  end

  describe "POST /employees" do
    it "creates an employee" do
      params = {
        employee: {
          first_name: "John",
          last_name: "Doe",
          job_title: "Engineer",
          country: "India",
          salary: 50000
        }
      }

      expect {
        post "/employees", params: params
      }.to change(Employee, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /employees/:id" do
    let!(:employee) { create(:employee) }

    it "deletes employee" do
      delete "/employees/#{employee.id}"

      expect(response).to have_http_status(:no_content)
      expect(Employee.exists?(employee.id)).to be_falsey
    end
  end
end