class Team < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'user_id', class_name: 'User'
  has_and_belongs_to_many :users, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true
end
