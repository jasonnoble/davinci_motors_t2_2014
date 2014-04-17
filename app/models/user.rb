class User < ActiveRecord::Base
  has_secure_password(validations: false)

  validates_confirmation_of :password,
    if: lambda { |user| !user.omniauth? && user.password.present? }
  validates_presence_of :password, :on => :create,
    if: lambda { |user| !user.omniauth? }
  validates_presence_of :password_confirmation, :on => :create,
    if: lambda { |user| !user.omniauth? && user.password.present? }

  has_many :cars

  def needs_verification!
    update_attributes(
      verified_email: false,
      token: SecureRandom.urlsafe_base64,
    )
    UserNotifier.signed_up(self).deliver
  end
end
