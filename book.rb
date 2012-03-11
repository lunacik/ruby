
module LIBIS

class Book
  def initialize(title, author, isbn, year, publisher)
    @title = title
    @author = author
    @isbn = isbn
    @year = year
    @publisher = publisher
  end

  attr :title, :author, :isbn, :year, :publisher

end

end #module
