
require './library'
require './spec_helper'


describe Library do
  before :all do
    @bt = "books_test.yml"
    @at = "acc_test.yml"

    Book.new("Baltoji iltis", "Jack London", 1906, "Mano knyga", 4).add!
    Book.new("Heroinas", "Melvin Burgess", 1995, "Baltos lankos", 2).add!
    Book.new("Alchemikas", "Paulo Coehlo", 1995, "Mano knyga", 1).add!
    Book.new("Kelias Atgal", "Erich Maria Remarque", 1930, "VVL", 5).add!
    Book.new("Kelias Namo", "Ghost Writer", 2012, "VKL", 3).add!

    User.new("Valerij", "Bielskij", Date.new(1990, 4, 29), "lunacik@epastas.lt").add!
    User.new("Eduard", "Bielskij", Date.new(1992, 3, 20), "edka@one.lt").add!
        
    Supervisor.new("Paulius", "Dovidauskas", Date.new(1980, 03, 20), 2353434).add!

    Administrator.new("Andrius", "Kasperas", Date.new(1960, 01, 01), 232422).add!

    File.open @bt, "w" do |f|
      f.write YAML::dump Book.all
    end

    File.open @at, "w" do |f|
      f.write YAML::dump ({
        :users => User.all, :supervisors => Supervisor.all,
        :administrators => Administrator.all
      })
    end

    Book.clear
    User.clear
    Supervisor.clear
    Administrator.clear
  end

  before :all do
    @library = Library.new({:books => @bt, :accounts => @at})
  end

  describe "#new" do
    #context "with no parameters" do
    #  specify "should have no books" do
    #    Library.new
    #    Book.all.should be_empty
    #  end
    #
    #  specify "should have no accounts" do
    #    User.all.should be_empty
    #  end
    #end

    context "with yaml file parameter" do
      it "should have 5 books" do
        Book.count.should == 5
      end

      it "should have 1 supervisor" do
        Supervisor.count.should == 1
      end
    end
  end

  it "should save books correctly" do
    @library.save_books
    books = Book.all
    Book.clear
    Library.new :books => "books.yml"
    books.should == Book.all 
  end

  it "should allow to connect to information system for users" do
    @library.connect(0, "Bielskij").should == User.all.first
  end

  it "should allow to connect to information system for supervisors" do
    @library.connect(2, "Dovidauskas").should be_instance_of Supervisor
  end

  it "should allow to connect to information system for admnis" do
    @library.connect(3, "Kasperas").should be_instance_of Administrator
  end

  it "should not allow to connect for unregistered users" do
    lambda {
        @library.connect(6, "Kazkoks")
    }.should raise_error "Wrong username or password, please try again"
  end

  it "should not allow to connect if wrong password specified" do
    lambda {
        @library.connect(0, "biel")
    }.should raise_error "Wrong username or password, please try again"
  end

end


