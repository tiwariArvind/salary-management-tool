# spec/factories/employees.rb
FactoryBot.define do
  factory :employee do
    first_name { "John" }
    last_name  { "Doe" }
    job_title  { "Engineer" }
    country    { "India" }
    salary     { 50000 }
    department { "Tech" }
  end
end