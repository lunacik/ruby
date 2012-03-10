
require './worker'

class Supervisor < Worker
  def initialize(name, surname, birthday, pin, address, sin, salary=2000)
    super(name, surname, birthday, pin, address, sin, salary)
  end
end

