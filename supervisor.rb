
require './worker'

module LIBIS

class Supervisor < Worker
  def initialize(name, surname, birthday, id, address, sin, salary=2000)
    super(name, surname, birthday, id, address, sin, salary)
  end
end

end #module
