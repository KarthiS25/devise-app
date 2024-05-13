class OtpVerification < ApplicationRecord
  belongs_to :verifiable, polymorphic: true

  def self.generate_otp(medium, value, verifiable = nil)
    otp = Random.rand(11_11..99_99)
    otp_record = find_or_initialize_by(verification_medium: medium, medium_value: value, code: otp)
    otp_record.expiry_at = Time.zone.now + ENV["OTP_EXPIRE_TIME"]
    otp_record.verifiable = verifiable if verifiable.present?
    otp_record.save!
    otp_record
  end

  def send_otp_to_phone(phone_number)
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    client.messages.create(
      body: "Please dont share this OTP #{code}",
      from: ENV.fetch("OTP_SENDER_MOBILE"),
      to: phone_number
    )
  end

  def valid_otp?(otp)
    code == otp && Time.zone.now < expiry_at
  end
end