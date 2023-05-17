class QuestionPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  attr_reader :employee, :record

  def initialize(employee, record)
    @employee = employee
    @record = record
  end

  # def index?
  #   @employee.HR? || @employee.manager?
  # end

  def show?
    @employee.HR? || @employee.manager?
  end

  def update?
    @employee.subordinate?
  end

  def create?
    @employee.subordinate?
  end

  def destroy?
    @employee.HR? || @employee.manager?
  end

end
