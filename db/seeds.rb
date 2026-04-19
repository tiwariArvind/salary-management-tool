# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
require 'faker'

records = []

10_000.times do
  first = Faker::Name.first_name
  last = Faker::Name.last_name

  records << {
    first_name: first,
    last_name: last,
    full_name: "#{first} #{last}",
    job_title: ["Engineer", "Manager", "HR", "Sales"].sample,
    country: ["India", "USA", "UK"].sample,
    salary: rand(30000..150000),
    department: ["Tech", "HR", "Sales"].sample,
    created_at: Time.now,
    updated_at: Time.now
  }
end

Employee.insert_all(records)