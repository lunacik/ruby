
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

  def extend(books_examples, book_id, user_id)
    raise "Cannot extend nonexistent book" unless @books_taken[book_id]
    @books_taken[book_id] = Date.today
    books_examples[book_id][:who][user_id] = Date.today
  end

  def return(books_examples, book_id, user_id)
    raise "Cannot return nonexistent book" unless @books_taken[book_id]
    @books_taken.delete(book_id)
    books_examples[book_id][:who].delete(user_id)
    books_examples[book_id][:count] += 1
  end

end
