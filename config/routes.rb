# config/routes.rb
Rails.application.routes.draw do
  resources :employees

  get "insights/salary_by_country"
  get "insights/job_title_avg"
  get "insights/dashboard"
end