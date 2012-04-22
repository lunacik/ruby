
require './person'
require './tools'
require './book'


class User < Person
  attr :email, :books_taken

  include AgeRange

  @collection = []

  def initialize(*args, birthday, email)
    check_age(birthday, MIN_USER_AGE)
    super(*args, birthday)
    @email = email
    @books_taken = {}
  end

  def extend(book)
    raise "Cannot extend nonexistent book" unless @books_taken[book]
    @books_taken[book] = Date.today
    book.examples.records[self] = Date.today
  end

  def return(book)
    raise "Cannot return nonexistent book" unless @books_taken[book]
    @books_taken.delete(book)
    book.examples.delete(self)
  end

end
