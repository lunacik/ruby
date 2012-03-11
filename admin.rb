
require './worker'

module LIBIS

class Admin < Worker
  def initialize(name, surname, birthday, id, address, sin, salary=3000)
    super(name, surname, birthday, id, address, sin, salary)
  end
end

end #module
