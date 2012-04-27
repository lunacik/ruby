require './book'
require './library'



RSpec::Matchers.define :have_id_equal do |expected_id|
  match do |actual|
    actual.class.add(actual)
    actual.id == expected_id
  end
end


RSpec::Matchers.define :save_books_correctly do
  match do |library|
    library.save_books("books.yml")
    books = Book.all
    Book.clear
    Library.new :books => "books.yml"
    books.should == Book.all 
  end
end

