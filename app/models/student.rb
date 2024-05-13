class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :otp_verifications, as: :verifiable
  after_create :generate_phone_verification_code

  def generate_phone_verification_code
    otp = OtpVerification.generate_otp("phone", phone_number, self)
    otp.send_otp_to_phone(phone_number)
  end
end
