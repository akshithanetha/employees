# frozen_string_literal: true

class Employees::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, options={})
    render json: {
      status: { code: 200, message: "Employee Signed in Successfully", data: current_employee }
    }, status: :ok
  end

 def respond_to_on_destroy
  jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1],
     Rails.application.credentials.fetch(:secret_key_base)).first
  current_employee = Employee.find(jwt_payload["sub"])
  if current_employee
    render json: {
      status: 200,
      message: "Signed out Successfully"
    }, status: :ok
  else
    render json: {
      status: 401,
      message: "Employee has no active session"
    }, status: :unauthorized
  end
 end

end
