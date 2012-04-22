
require './person'
require './tools'


class Worker < Person
  attr :sin
  attr_accessor :salary
  include AgeRange

  @collection = []

  def initialize(*args, birthday, sin, salary)
    check_age(birthday, MIN_WORKER_AGE)
    super(*args, birthday)
    @sin = sin
    @salary = salary
  end
end
