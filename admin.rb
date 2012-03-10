
require './worker'

class Admin < Worker
  def initialize(name, surname, birthday, pin, address, sin, salary=3000)
    super(name, surname, birthday, pin, address, sin, salary)
  end
end
