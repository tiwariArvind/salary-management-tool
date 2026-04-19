# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject do
    described_class.new(
      first_name: "John",
      last_name: "Doe",
      job_title: "Engineer",
      country: "India",
      salary: 50000,
      department: "Tech"
    )
  end

  # ------------------------
  # ✅ VALIDATIONS
  # ------------------------

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without first_name" do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without last_name" do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without job_title" do
    subject.job_title = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without country" do
    subject.country = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without salary" do
    subject.salary = nil
    expect(subject).not_to be_valid
  end

  it "is invalid with negative salary" do
    subject.salary = -100
    expect(subject).not_to be_valid
  end

  it "is invalid with zero salary" do
    subject.salary = 0
    expect(subject).not_to be_valid
  end

  # ------------------------
  # ✅ CALLBACKS
  # ------------------------

  it "sets full_name before save" do
    subject.save
    expect(subject.full_name).to eq("John Doe")
  end

  it "updates full_name when first_name changes" do
    subject.save
    subject.update(first_name: "Jane")
    expect(subject.full_name).to eq("Jane Doe")
  end

  # ------------------------
  # ✅ EDGE CASES
  # ------------------------

  it "handles large salary values" do
    subject.salary = 1_000_000_000
    expect(subject).to be_valid
  end

  it "trims whitespace in names (if implemented)" do
    subject.first_name = "  John "
    subject.last_name = " Doe  "
    subject.save

    expect(subject.full_name).to eq("John Doe")
  end
end