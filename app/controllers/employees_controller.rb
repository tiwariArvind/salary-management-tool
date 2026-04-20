# app/controllers/employees_controller.rb
class EmployeesController < ApplicationController
  def index
  employees = Employee
                .order(updated_at: :desc)
                .page(params[:page])
                .per(50)

  render json: employees
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