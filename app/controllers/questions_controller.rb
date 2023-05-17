class QuestionsController < ApplicationController
  before_action :authenticate_employee!

  def index
    questions = Question.all

    # authorize employee
    render json: questions, status: 200
  end


  def show
    question = Question.find(params[:id])
    employee = question.employee
    authorize employee
    render json: question, status: 200
  end

  def create
    question = Question.new(question_params)
    employee = question.employee
    authorize employee
    if question.save
      render json: question, status: 200
    else
      render json: {message: "Question Cannot be created", error: question.errors.full_messages}
    end
  end

  def update
    question = Question.find(params[:id])
    employee = question.employee
    authorize employee
    if question.update(question_params)
      render json: question, status: 200
    else
      render json: {message: "Question cannot be updated", error: question.errors.full_messages}
    end
  end

  def destroy
    question = Question.find(params[:id])
    employee = question.employee
    authorize employee
    question.destroy
    render json: {message: "Record Destroyed Successfully"}
  end

  private

  def question_params
    params.require(:question).permit(:query, :employee_id, :clarified, :remarks)
  end



end
