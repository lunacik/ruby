
require './worker'


class Supervisor < Worker
  def initialize(*args)
    super(*args)
  end
end
