
require 'date'


class Person
  attr :name, :surname, :birthday, :id
  
  def initialize(name, surname, birthday, id)
    @name = name
    @surname = surname
    @birthday = birthday
    @id = id
  end

end

