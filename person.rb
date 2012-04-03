
require 'date'


class Person
  attr :name, :surname, :birthday

  def initialize(name, surname, birthday)
    raise "Cannot create person without name" if name == ""
    raise "Cannot create person without surname" if surname == ""
    @name = name
    @surname = surname
    @birthday = birthday
  end
end
