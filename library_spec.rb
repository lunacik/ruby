
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

    users = {
        0 => User.new("Valerij", "Bielskij", Date.new(1990, 4, 29), "lunacik@epastas.lt"),
        1 => User.new("Eduard", "Bielskij", Date.new(1992, 3, 20), "edka@one.lt")
    }

    supervisors = {
        2 => Supervisor.new("Paulius", "Dovidauskas", Date.new(1980, 03, 20), 2353434)
    }

    File.open "books.yml", "w" do |f|
      f.write YAML::dump books
    end

    File.open "accounts.yml", "w" do |f|
      f.write YAML::dump ({:users => users, :supervisors => supervisors})
    end
  end

  before :each do
    @library = Library.new ({:books => "books.yml", :acc => "accounts.yml"})
  end

  describe "#new" do
    context "with no parameters" do
      specify "should have no books" do
        library = Library.new
        library.should have(0).books
      end

      specify "should have no accounts" do
        library = Library.new
        library.should have(0).users
      end
    end

    context "with yaml file parameter" do
      specify "should have 5 books" do
        @library.should have(5).books
      end

      specify "should have 1 supervisor" do
        @library.should have(1).supervisors
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

  it "should accept new accounts" do
    @library.add_acc(:users, User.new("Tatjana", "Bielskaja", Date.new(1968, 12, 29), "mama@pastas.lt"))
    @library.should have(3).users
  end

  it "should save books correctly" do
    @library.save_books
    new_library = Library.new :books => "books.yml"
    new_library.books.should == @library.books 
  end

  it "should save accounts correctly" do
    @library.save_accounts
    new_library = Library.new :acc => "accounts.yml"
    new_library.users.should == @library.users
  end
end


