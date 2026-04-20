class SalaryInsightsService
  # 1. Salary stats by country (min, max, avg)
  def self.salary_by_country(country)
    data = Employee
             .where(country: country)
             .select(
               "MIN(salary) as min_salary,
                MAX(salary) as max_salary,
                AVG(salary) as avg_salary"
             ).take

    {
      country: country,
      min_salary: data&.min_salary&.to_f || 0.0,
      max_salary: data&.max_salary&.to_f || 0.0,
      avg_salary: data&.avg_salary&.to_f || 0.0
    }
  end

  # 2. Avg salary by job title within country
  def self.job_title_avg(country, job_title)
    avg = Employee
            .where(country: country, job_title: job_title)
            .average(:salary)

    {
      country: country,
      job_title: job_title,
      avg_salary: avg&.to_f || 0.0
    }
  end


  def self.country_stats(country)
    employees = Employee.where(country: country)

    return { min: 0, max: 0, avg: 0 } if employees.empty?

    min = employees.minimum(:salary)
    max = employees.maximum(:salary)
    avg = employees.average(:salary)

    {
      min: min.to_i,
      max: max.to_i,
      avg: avg.to_i
    }
  end

  # 3. Dashboard stats
  def self.dashboard(country)
    employees = Employee.where(country: country)

    {
      country: country,
      total_employees: employees.count,
      avg_salary: employees.average(:salary)&.to_f || 0.0,
      max_salary: employees.maximum(:salary)&.to_f || 0.0,
      min_salary: employees.minimum(:salary)&.to_f || 0.0,
      top_5: employees.order(salary: :desc).limit(5)
    }
  end
end