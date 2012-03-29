
require 'date'


class Book
  attr :title, :author, :year, :publisher
  
  def initialize(title, author, year, publisher)
    #raise "Cant create book with year greater than current" if year > Date.today.year
    raise "Cant create book without title" if title.empty?
    raise "Cant create book without author" if author.empty?
    raise "Cant create book without publisher" if publisher.empty?
    @title = title
    @author = author
    @year = year
    @publisher = publisher
  end

  def ==(other)
    self.instance_variables.each do |ivar| 
      return false if self.instance_variable_get(ivar) != other.instance_variable_get(ivar)
    end
    #return false if self.title != other.title
    #return false if self.author != other.author
    #return false if self.year != other.year
    #self.publisher == other.publisher
  end
end
