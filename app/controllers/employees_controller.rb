# app/controllers/employees_controller.rb
class EmployeesController < ApplicationController

  def index
  employees = Employee.all
  employees = employees.where(country: params[:country]) if params[:country].present?

  if params[:q].present?
    query = "%#{params[:q].strip}%"
    employees = employees.where("full_name ILIKE ?", query)
  end

  # 📄 Pagination (with clamp)
  per_page = safe_per_page

  employees = employees
                .order(updated_at: :desc)
                .page(params[:page])
                .per(per_page)

  render json: {
    data: employees,
    meta: {
      current_page: employees.current_page,
      total_pages: employees.total_pages,
      total_count: employees.total_count,
      per_page: per_page
    }
  }
end

def show
  render json: Employee.find(params[:id])
end

def create
  employee = Employee.new(employee_params)
  if employee.save
    render json: employee, status: :created
  else
    render json: employee.errors, status: :unprocessable_entity
  end
end

def update
  employee = Employee.find(params[:id])
  if employee.update(employee_params)
    render json: employee
  else
    render json: employee.errors, status: :unprocessable_entity
  end
end

def destroy
  Employee.find(params[:id]).destroy
  head :no_content
end

private

def employee_params
  params.require(:employee).permit(:first_name, :last_name, :job_title, :country, :salary, :department)
end

def safe_per_page
  value = params[:per_page].to_i
  return 50 if value <= 0
  [value, 100].min
end
end