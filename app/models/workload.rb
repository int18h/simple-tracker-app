class Workload < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user
  validates :description, presence: true
  validates :hours, presence: true, numericality: {greater_than_or_equal_to: 0.01}
end
