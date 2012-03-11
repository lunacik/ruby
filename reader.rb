
require './person'

module LIBIS

class Reader < Person
  def initialize(name, surname, birthday, id, address, email)
    super(name, surname, birthday, id, address)
    @email = email
    @books_taken = []
  end

  attr_accessor :email

end

end #module
