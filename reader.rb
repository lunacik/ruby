
require './person'

class Reader < Person
  def initialize(name, surname, birthday, pin, address, id, email)
    super(name, surname, birthday, pin, address)
    @id = id
    @email = email
  end

  attr_reader :id
  attr_accessor :email

end

