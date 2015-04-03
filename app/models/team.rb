class Team < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :users, dependent: :destroy

  validates :name, presence: true
  validates :owner_id, presence: true

end
