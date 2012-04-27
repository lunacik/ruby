

require './worker'
require './supervisor'


class Administrator < Worker
  @collection = []

  def initialize(name, surname, birthday, sin, salary=3000)
    super(name, surname, birthday, sin, salary)
  end

  def set_salary(supervisor, salary)
    raise "Cannot set negative salary" if salary < 0
    raise "Cannot set salary for nonexistent supervisor" unless Supervisor.all.include?(supervisor)
    supervisor.salary = salary
  end
end
