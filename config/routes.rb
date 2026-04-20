# config/routes.rb
Rails.application.routes.draw do
  resources :employees

  get "insights/salary_by_country"
  get "insights/job_title_avg"
  get "insights/dashboard"

  get "/insights/country", to: "insights#salary_by_country"
  get "/insights/job_title", to: "insights#job_title_avg"
end