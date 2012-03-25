
require './person'


class Reader < Person
  attr :email

  def initialize(name, surname, birthday, id, email)
    super(name, surname, birthday, id) 
    @email = email
  end

end
