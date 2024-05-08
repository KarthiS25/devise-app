class ApplicationController < ActionController::API

  def response_success(message, status, data = [])
    json_resp = { message: }
    json_resp['data'] = data
    render json: json_resp, status:
  end
end
