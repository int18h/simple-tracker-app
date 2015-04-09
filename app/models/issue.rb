class Issue < ActiveRecord::Base
  enum status: [:opened, :working, :resolved, :closed ]
  belongs_to :worker, foreign_key: 'owner_id', class_name: 'User'
  has_one :user
end
