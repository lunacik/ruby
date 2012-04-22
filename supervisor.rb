
require './worker'
require './user'
require './book'


class Supervisor < Worker
  def initialize(name, surname, birthday, sin, salary=2000)
    super(name, surname, birthday, sin, salary)
  end

  @collection = []

  def lend(user, book)
    raise "Cannot lend book for unregistered user" unless User.all.include?(user)
    if user.books_taken.length >= MAX_BOOKS_ALLOWED
      raise "Cannot take books more than #{MAX_BOOKS_ALLOWED}" 
    end
    raise "You already possess that book" if user.books_taken[book]
    raise "Cannot lend nonexistent book" unless Book.all.include?(book)
    user.books_taken[book] = Date.today
    book.examples.records[user] = Date.today
  end

  def extend(user, book)
    raise "Cannot extend nonexistent book" unless user.books_taken[book]
    user.books_taken[book] = Date.today
    book.examples.records[user] = Date.today
  end

end
