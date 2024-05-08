class Api::V1::UserSessionsController < Devise::RegistrationsController
  respond_to :json
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
end