

class Person
  def initialize(name, surname, birthday, pin, address)
    @name = name
    @surname = surname
    @birthday = birthday
    @pin = pin
    @address = address
  end

  attr_reader :name, :surname, :birthday, :pin
  attr_accessor :address

end  
  

