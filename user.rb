
require './person'
require './tools'


class User < Person
  attr :email, :books_taken

  include AgeRange

  def initialize(*args, birthday, email)
    check_age(birthday, MIN_USER_AGE)
    super(*args, birthday)
    @email = email
    @books_taken = {}
  end

  def take_book(book_id)
    if @books_taken.length == MAX_BOOKS_ALLOWED
      raise "Cannot take books more than #{MAX_BOOKS_ALLOWED}" 
    end
    @books_taken[book_id] = Date.today
  end

  def return_book(book_id)
    raise "Cannot return nonexistent book" unless @books_taken[book_id]
    @books_taken.delete(book_id)
  end

  def extend_book(book_id)
    raise raise "Cannot extend nonexistent book" unless @books_taken[book_id]
    @books_taken[book_id] = Date.today
  end
end
