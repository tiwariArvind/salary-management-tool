# spec/services/salary_insights_service_spec.rb
require 'rails_helper'

RSpec.describe SalaryInsightsService do
  describe ".country_stats" do
    before do
      create(:employee, country: "India", salary: 50000)
      create(:employee, country: "India", salary: 70000)
    end

    it "calculates min, max, avg" do
      result = described_class.country_stats("India")

      expect(result[:min]).to eq(50000)
      expect(result[:max]).to eq(70000)
      expect(result[:avg]).to eq(60000)
    end
  end
end