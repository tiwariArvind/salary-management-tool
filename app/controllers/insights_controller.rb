# app/controllers/insights_controller.rb
class InsightsController < ApplicationController
  def salary_by_country
    data = Employee.where(country: params[:country])
                   .select(
                     "MIN(salary) as min_salary,
                      MAX(salary) as max_salary,
                      AVG(salary) as avg_salary"
                   ).take

    render json: data
  end

  def job_title_avg
    avg = Employee.where(
      country: params[:country],
      job_title: params[:job_title]
    ).average(:salary)

    render json: { avg_salary: avg }
  end

  def dashboard
    employees = Employee.where(country: params[:country])

    render json: {
      total_employees: employees.count,
      avg_salary: employees.average(:salary),
      max_salary: employees.maximum(:salary),
      min_salary: employees.minimum(:salary),
      top_5: employees.order(salary: :desc).limit(5)
    }
  end
end