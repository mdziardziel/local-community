class Authentication::User < Authentication::ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  belongs_to :community
end
