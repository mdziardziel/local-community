class Authentication::Community < Authentication::ApplicationRecord
  has_many :users, dependent: :destroy
end
