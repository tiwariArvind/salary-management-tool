class Employee < ApplicationRecord
  validates :first_name, :last_name, :job_title, :country, :salary, presence: true
  validates :salary, numericality: { greater_than: 0 }

  before_save :set_full_name

  private

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
end
