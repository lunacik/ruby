
require './person'


class Worker < Person
  attr :sin
  attr_accessor :salary

  def initialize(name, surname, id, birthday, sin, salary)
    super(name, surname, id, birthday)
    @sin = sin
    @salary = salary
  end
end
