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

    salaries = employees.pluck(:salary).compact.sort
    count = salaries.size

    return empty_response if count == 0

    {
      total_employees: count,
      min: salaries.first,
      max: salaries.last,
      avg: (salaries.sum / count.to_f).round(2),
      median: median(salaries),
      segments: salary_segments(salaries),
      currency_breakdown: currency_breakdown(employees)
    }
  end

  private

  # 📊 Median
  def self.median(arr)
    len = arr.length
    mid = len / 2

    if len.odd?
      arr[mid]
    else
      ((arr[mid - 1] + arr[mid]) / 2.0).round(2)
    end
  end

  # 📊 Salary buckets
  def self.salary_segments(salaries)
    {
      low: salaries.count { |s| s < 50000 },
      mid: salaries.count { |s| s.between?(50000, 100000) },
      high: salaries.count { |s| s > 100000 }
    }
  end

  # 💱 Currency breakdown
  def self.currency_breakdown(employees)
    employees.group(:currency).count
  end

  def self.empty_response
    {
      total_employees: 0,
      min: 0,
      max: 0,
      avg: 0,
      median: 0,
      segments: { low: 0, mid: 0, high: 0 },
      currency_breakdown: {}
    }
  end
end