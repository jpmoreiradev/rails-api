class Task < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed], allow_nil: true }
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

  before_save :set_default_values

  private

  def set_default_values
    self.status ||= "pending"
    self.completed ||= false
    self.priority ||= 3
  end
end
