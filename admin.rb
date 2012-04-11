

require './worker'
require './supervisor'


class Administrator < Worker
  def initialize(name, surname, birthday, sin, salary=3000)
    super(name, surname, birthday, sin, salary)
  end

  def set_salary(supervisor, supervisor_id, supervisors, salary)
    raise "Cannot set negative salary" if salary < 0
    raise "Cannot set salary for nonexistent supervisor" unless supervisors[supervisor_id]
    supervisor.salary = salary
  end
end
