
#require 'psych'
require 'yaml'
require './book'
require './tools'


class Fixnum
  def upcase
    self
  end
  alias include? ==
end


class Library
  attr :books
  include IDGenerator

  def initialize(books_file = false)
    @books_file = books_file
    @books = @books_file ? YAML::load_file(@books_file) : {}
    @book_ids = @books.keys
  end

  def get_books(category, pattern)
    books = []
    @books.each do |id, book| 
      books.push(id) if eval("book." + category.to_s).upcase.include?(pattern.upcase)
    end
    books
  end

  def add_book(new_book)
    @books[new_id(@book_ids)] = new_book
  end

  def save(books_file = false)
    @books_file = books_file || @books_file || "books.yml"
    File.open(@books_file, "w") do |f|
      f.write(YAML::dump @books)
    end
  end
end


