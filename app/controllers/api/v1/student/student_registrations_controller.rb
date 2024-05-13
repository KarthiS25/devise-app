class Api::V1::Student::StudentRegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    if sign_up_params[:id].present?
      student = Student.find_by(id: sign_up_params[:id])
      sign_in(:student, student)
      respond_with(student)
    elsif sign_up_params[:phone_number]
      build_resource(sign_up_params)
      super
    end
  end

  def generate_otp
    Student.transaction do
      student = Student.find_or_create_by(phone_number: otp_params[:phone_number])
      render json: {student: student}
    end
  end

  private
  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: 200, message: 'Signed up successfully.'
      }, status: :ok
    else
      render json: {
        status: { message: "Student couldn't be created successfully." }
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:student).permit(:id, :email, :phone_number, :password, :password_confirmation, :otp)
  end

  def otp_params
    params.require(:student).permit(:phone_number)
  end
end