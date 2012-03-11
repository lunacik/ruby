
module LIBIS

class Person
  def initialize(name, surname, birthday, id, address)
    @name = name
    @surname = surname
    @birthday = birthday
    @id = id
    @address = address
  end

  attr_reader :name, :surname, :birthday, :id
  attr_accessor :address

end  
  
end #module
