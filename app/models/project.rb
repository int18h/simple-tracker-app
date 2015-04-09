class Project < ActiveRecord::Base
  enum status: [:active, :closed]
  belongs_to :owner, foreign_key: 'user_id', class_name: 'User'
  has_many :issues
  belongs_to :team, foreign_key: 'team_id', class_name: 'Team'
  validates :name, presence: true, uniqueness: true
  validates :team_id, presence: true
end
