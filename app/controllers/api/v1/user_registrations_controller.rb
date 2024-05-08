class Api::V1::UserRegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    if sign_up_params[:id].present?
      user = User.find_by(id: sign_up_params[:id])
      sign_in(:user, user)
      respond_with(user)
    elsif sign_up_params[:phone_number]
      build_resource(sign_up_params)
      super
    end
  end

  def generate_otp
    user = User.create!(phone_number: otp_params[:phone_number], otp: otp_params[:otp])
    render json: {id: user.id, otp: user.otp}
  end

  private
  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: 200, message: 'Signed up successfully.'
      }, status: :ok
    else
      render json: {
        status: { message: "User couldn't be created successfully." }
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:id, :email, :phone_number, :password, :password_confirmation, :otp)
  end

  def otp_params
    params.require(:user).permit(:phone_number).merge(otp: otp)
  end

  def otp
    SecureRandom.rand(111_111..999_999)
  end
end