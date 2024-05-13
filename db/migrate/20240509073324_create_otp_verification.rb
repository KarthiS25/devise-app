class CreateOtpVerification < ActiveRecord::Migration[7.0]
  def change
    create_table :otp_verifications do |t|
      t.string    :verification_medium
      t.string    :medium_value
      t.integer   :code
      t.datetime  :expiry_at
      t.boolean   :verified, default: false
      t.references :verifiable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
