class InsightsController < ApplicationController
  def salary_by_country
    render json: SalaryInsightsService.salary_by_country(params[:country])
  end

  def job_title_avg
    render json: SalaryInsightsService.job_title_avg(
      params[:country],
      params[:job_title]
    )
  end

  def dashboard
    render json: SalaryInsightsService.dashboard(params[:country])
  end
end