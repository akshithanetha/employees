class EmployeesController < ApplicationController
  before_action :authenticate_employee!

  def index
    employees = Employee.all
    render json: employees, status: 200
  end

  def subordinates
    manager = Employee.find(params[:id])
    subordinates = manager.subordinates
    render json: subordinates, status: 200
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee, status: 200
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee, status: 200
    else
      render json: {message: "Employee Cannot be created", error: employee.errors.full_messages}
    end
  end

  def update
    employee = Employee.find(params[:id])
    if employee.update(employee_params)
      render json: employee, status: 200
    else
      render json: {message: "Employee cannot be updated", error: employee.errors.full_messages}
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    render json: {message: "Record Destroyed Successfully"}
  end

  private

  def employee_params
    params.require(:employee).permit(:name,:role,:manager_id)
  end

end
