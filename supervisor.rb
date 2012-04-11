
require './worker'
require './user'


class Supervisor < Worker
  def initialize(name, surname, birthday, sin, salary=2000)
    super(name, surname, birthday, sin, salary)
  end

  def lend(books_examples, users, book_id, user, user_id)
    raise "Cannot lend book for unregistered user" unless users[user_id]
    if user.books_taken.length == 5
      raise "Cannot take books more than #{MAX_BOOKS_ALLOWED}" 
    end
    raise "You already possess that book" if user.books_taken[book_id]
    raise "Cannot lend nonexistent book" unless books_examples[book_id]
    user.books_taken[book_id] = Date.today
    books_examples[book_id][:who][user_id] = Date.today
    books_examples[book_id][:count] -= 1
  end

  def extend(books_examples, book_id, user, user_id)
    raise "Cannot extend nonexistent book" unless user.books_taken[book_id]
    user.books_taken[book_id] = Date.today
    books_examples[book_id][:who][user_id] = Date.today
  end

end
