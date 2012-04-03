
require 'date'


class Person
  attr :name, :surname, :id, :birthday

  def initialize(name, surname, id, birthday)
    raise "Cannot create person without name" if name == ""
    raise "Cannot create person without surname" if surname == ""
    @name = name
    @surname = surname
    @id = id
    @birthday = birthday
  end
end
