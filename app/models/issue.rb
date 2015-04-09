class Issue < ActiveRecord::Base
  enum status: [:opened, :working, :resolved, :closed ]
  belongs_to :owner, foreign_key: 'user_id', class_name: 'User'
  belongs_to :project
  has_many :workloads
  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :estimated_hours, numericality: {greater_than_or_equal_to: 0.01}
  validates :status, presence: true
end
