class Authentication::UpdateUserForm
  include ActiveModel::Validations

  attr_accessor :current_password, :new_password, :new_password_confirmation
  delegate :persisted?, to: "@user"

  validate :current_password_correct
  validate :password_confirmation

  validates :current_password, :new_password, :new_password_confirmation, presence: true

  def initialize(user, attributes = {})
    @user = user
    self.current_password = attributes[:current_password]
    self.new_password = attributes[:new_password]
    self.new_password_confirmation = attributes[:new_password_confirmation]
  end

  def submit    
    return unless valid?

    @user.assign_attributes(
      password: new_password,
      password_confirmation: new_password_confirmation
    )
    return true if @user.save

    self.errors.merge!(@user.errors)

    false
  end

  private

  def current_password_correct
    return if @user.authenticate(current_password)

    errors.add(:current_password, :invalid)
  end

  def password_confirmation
    return if new_password == new_password_confirmation

    errors.add(:new_password_confirmation, :invalid)
  end
end
