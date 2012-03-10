
class Book
  def initialize(title, author, isbn, year, pub_house)
    @title = title
    @author = author
    @year = year
    @pub_house = pub_house
  end

  attr :title, :author, :year, :pub_house

end
