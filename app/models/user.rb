class User < ActiveRecord::Base
  attr_reader :full_name

  has_many :teams, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :workloads, dependent: :destroy
  #has_many :issues, depedent: :destroy

  has_and_belongs_to_many :in_teams, class_name: 'Team', dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_destroy :ensure_not_referenced_by_any_team
  after_find :set_full_name

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: {minimum: 6}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def is_owner_of_team(user)
    return true if (current_user.id == owner.id)
  rescue
    return false
  end
  private
    def set_full_name
      @full_name = "#{first_name} #{last_name}"
    end
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
    def ensure_not_referenced_by_any_team
      if user.in_teams.empty?
        return true
      else
        errors.add(:base, 'User is still assigned to some teams.')
        return false
      end
    end
end
