
#require 'psych'
require 'yaml'
require './book'


class Fixnum
  def upcase
    self
  end
  alias include? ==
end


class Library
  attr :books

  def initialize(books_file = false)
    @books_file = books_file
    @books = @books_file ? YAML::load_file(@books_file) : []
  end

  def get_books(category, pattern)
    books = []
    @books.each do |book| 
      books.push(book) if eval("book." + category.to_s).upcase.include?(pattern.upcase)
    end
    books
=begin
    case category
      when :title then @books.each do |book| 
        books.push(book) if book.title.upcase.include?(pattern.upcase)
      end
      
      when :author then @books.each do |book|
        books.push(book) if book.author.upcase.include?(pattern.upcase)
      end

      when :year then @books.each do |book|
        books.push(book) if book.year == pattern
      end
 
      when :publisher then @books.each do |book|
        books.push(book) if book.publisher.upcase.include?(pattern.upcase)
      end
    end
    books
=end
  end

  def add_book(new_book)
    @books.push(new_book) 
  end
  def save(books_file = false)
    @books_file = books_file || @books_file || "books.yml"
    File.open(@books_file, "w") do |f|
      f.write(YAML::dump @books)
    end
  end
end


