
require './person'
require './tools'


class Worker < Person
  attr :sin
  attr_accessor :salary
  include AgeRange

  def initialize(*args, birthday, sin, salary)
    check_age(birthday, 18)
    super(*args, birthday)
    @sin = sin
    @salary = salary
  end
end
