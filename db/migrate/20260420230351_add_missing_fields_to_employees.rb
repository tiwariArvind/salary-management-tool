class AddMissingFieldsToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :currency, :string
    add_column :employees, :email, :string
    add_column :employees, :hired_on, :date
    add_column :employees, :employment_status, :string
    add_column :employees, :employee_number, :string

    add_index :employees, :email, unique: true
    add_index :employees, :employee_number, unique: true
  end
end