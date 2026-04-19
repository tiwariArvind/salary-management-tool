class Employee < ApplicationRecord
  # ------------------------
  # VALIDATIONS
  # ------------------------
  validates :first_name, :last_name, :job_title, :country, :salary, presence: true
  validates :salary, numericality: { greater_than: 0 }

  # ------------------------
  # CALLBACKS
  # ------------------------
  before_save :normalize_names
  before_save :set_full_name

  private

  def normalize_names
    self.first_name = first_name.to_s.strip
    self.last_name  = last_name.to_s.strip
  end

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
end