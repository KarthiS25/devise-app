class Api::V1::Student::StudentSessionsController < Devise::RegistrationsController
  respond_to :json

  def create
    if sign_in_params[:phone_number].present?
      student = Student.find_or_create_by(phone_number: sign_in_params[:phone_number])
      if student.otp_verifications.where(verification_medium: "phone", medium_value: student.phone_number).last.valid_otp?(sign_in_params[:otp])
        sign_in(:student, student)
        respond_with(student)
      else
        render json: {
          status: 400,
          message: "Not found"
        }, status: :not_found
      end
    end
  end

  private
  def respond_with(resource, _opts={})
    render json: {
      status: 200,
      message: "Logged in successfully"
    }, status: :ok
  end

  def respond_to_on_destroy
    head :ok
  end

  def sign_in_params
    params.require(:student).permit(:id, :email, :phone_number, :password, :password_confirmation, :otp)
  end
end