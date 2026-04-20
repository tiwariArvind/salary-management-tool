# db/seeds.rb

puts "🧹 Cleaning existing employees..."
Employee.delete_all

puts "📦 Loading name datasets..."

first_names = File.readlines(
  Rails.root.join('lib/data/first_names.txt'),
  chomp: true
).reject(&:blank?)

last_names = File.readlines(
  Rails.root.join('lib/data/last_names.txt'),
  chomp: true
).reject(&:blank?)

raise "❌ Name files missing!" if first_names.empty? || last_names.empty?

TOTAL_RECORDS = 10_000
BATCH_SIZE = 1000

puts "🚀 Seeding #{TOTAL_RECORDS} employees..."

records = []

TOTAL_RECORDS.times do |i|
  first = first_names[i % first_names.length]
  last  = last_names.sample

  records << {
    first_name: first,
    last_name: last,

    job_title: ["Engineer", "Manager", "HR", "Sales"].sample,
    country: ["India", "USA", "UK"].sample,
    salary: rand(30_000..150_000),
    department: ["Tech", "HR", "Sales"].sample,

    email: "employee#{i}@example.com",
    currency: ["INR", "USD", "GBP"].sample,
    hired_on: Date.today - rand(0..1825),
    employment_status: ["active", "inactive", "terminated"].sample,
    employee_number: "EMP#{1000 + i}",

    created_at: Time.current,
    updated_at: Time.current
  }
end

puts "💾 Inserting records..."

records.each_slice(BATCH_SIZE) do |batch|
  Employee.insert_all(batch)
end

puts "🎉 Done! Total Employees: #{Employee.count}"