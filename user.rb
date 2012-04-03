
require './person'
require './tools'


class User < Person
  attr :email
  attr :books_taken

  include AgeRange

  def initialize(*args, birthday, email)
    check_age(birthday, MIN_USER_AGE)
    super(*args, birthday)
    @email = email
    @books_taken = []
  end
end
