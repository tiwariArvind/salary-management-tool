# app/controllers/employees_controller.rb
class EmployeesController < ApplicationController
  def index
    employees = Employee.all

    # ✅ Filter by country (if provided)
    if params[:country].present?
      employees = employees.where(country: params[:country])
    end

    # ✅ Pagination (Kaminari or WillPaginate assumed)
    employees = employees.page(params[:page]).per(params[:per_page] || 10)

    render json: {
      data: employees.as_json(
        only: [
          :id,
          :first_name,
          :last_name,
          :email,
          :job_title,
          :country,
          :salary,
          :department,
          :employee_number,
          :employment_status,
          :hired_on
        ]
      ),
      meta: {
        current_page: employees.current_page,
        total_pages: employees.total_pages,
        total_count: employees.total_count
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
end