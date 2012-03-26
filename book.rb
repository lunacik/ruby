
require 'date'


class Book
  attr :title, :author, :year, :publisher
  
  def initialize(title, author, year, publisher)
    raise "Cant create book with year greater than current" if year > Date.today.year
    raise "Cant create book without title" if title.empty?
    raise "Cant create book without author" if author.empty?
    raise "Cant create book without publisher" if publisher.empty?
    @title = title
    @author = author
    @year = year
    @publisher = publisher
  end

  def ==(other)
    self.instance_variables == other.instance_variables
  end
end
