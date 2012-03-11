
require './person'

module LIBIS

class Worker < Person
  def initialize(name, surname, birthday, pin, address, sin, salary)
    super(name, surname, birthday, pin, address)
    @salary = salary
    @sin = sin
  end

  attr :sin
  attr_accessor :salary

end

end #module
