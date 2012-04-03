
require './worker'


class Supervisor < Worker
  def initialize(name, surname, birthday, sin, salary=2000)
    super(name, surname, birthday, sin, salary)
  end
end
