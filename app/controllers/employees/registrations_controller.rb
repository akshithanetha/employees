# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  respond_to :json

   private

   def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: { code: 200, message: "Signed up Successfully", data: resource }

      }, status: :ok
    else
      render json: {
         status: { message: "Employee could not be created", errors: resource.errors.full_messages}, status: :unprocessable_entity
      }
    end
   end
end
