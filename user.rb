
require './person'
require './tools'


class User < Person
  attr :email
  attr :books_taken

  include AgeRange

  def initialize(name, surname, id, birthday, email)
    check_age(birthday, MIN_USER_AGE)
    super(name, surname, id, birthday)
    @email = email
    @books_taken = []
  end
end
