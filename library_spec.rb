
require './library'


describe Library do
  before :all do
    books = {
        0 => Book.new("Baltoji iltis", "Jack London", 1906, "Mano knyga"),
        1 => Book.new("Heroinas", "Melvin Burgess", 1995, "Baltos lankos"),
        2 => Book.new("Alchemikas", "Paulo Coehlo", 1995, "Mano knyga"),
        3 => Book.new("Kelias Atgal", "Erich Maria Remarque", 1930, "VVL"),
        4 => Book.new("Kelias Namo", "Ghost Writer", 2012, "VKL")
    }


    File.open "books.yml", "w" do |f|
      f.write YAML::dump books
    end
  end

  before :each do
    @library = Library.new "books.yml"
  end

  describe "#new" do
    context "with no parameters" do
      specify "should have no books" do
        library = Library.new
        library.should have(0).books
      end
    end

    context "with yaml file parameter" do
      specify "should have 5 books" do
        @library.should have(5).books
      end
    end
  end
  
  it "should return 2 books for search 'kelias' in title category" do
    @library.get_books(:title, "kelias").length.should == 2
  end

  it "should return 1 book for search 'Paul' in author category" do
    @library.get_books(:author, "Paul").length.should == 1
  end                  

  it "should return 2 books for search '1995' in year category" do
    @library.get_books(:year, 1995).length.should == 2
  end

  it "should return empty list for nonexistent publisher category" do
    @library.get_books(:publisher, "Vilniaus knygynas").should == []
  end

  it "should accept new books" do
    @library.add_book(Book.new("Didysis karas", "Antanas Vienuolis", 1940, "Mano knyga"))
    @library.get_books(:title, "Didysis karas").last.should == 5
  end

  it "should add new books correctly" do
    @library.add_book(Book.new("Didysis karas", "Antanas Vienuolis", 1940, "Mano knyga"))
    @library.should have(6).books
  end

  it "should save data correctly" do
    @library.save
    new_library = Library.new "books.yml"
    new_library.books.should == @library.books 
  end
end


