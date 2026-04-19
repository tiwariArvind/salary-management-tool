class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :job_title
      t.string :country
      t.decimal :salary
      t.string :department

      t.timestamps
    end
    add_index :employees, :country
    add_index :employees, :job_title
    add_index :employees, [:country, :job_title]
  end
end
