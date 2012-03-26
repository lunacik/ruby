

class Book
  attr :title, :author, :year, :publisher
  
  def initialize(title, author, year, publisher)
    @title = title
    @author = author
    @year = year
    @publisher = publisher
  end

  def ==(other)
    self.instance_variables == other.instance_variables
  end
end
