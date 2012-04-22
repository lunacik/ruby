
require './supervisor'
require './library'


describe Supervisor do
  before :all do
    @supervisor = Supervisor.new "Paulius", "Dovidauskas", 
        Date.new(1990, 4, 4), 23324, 1000

    @user = User.new "Valerij", "Bielskij", 
          Date.new(1990, 4, 29), "lunacik18@gmail.com"
    
    @book = Book.new "Nauja", "Ponas", 1989, "alka", 5
  end

  describe "#new" do
    it "should take 5 parameters and return 'Supervisor' object" do
      @supervisor.should be_instance_of Supervisor
    end
  end

  it "should inherit from 'Worker'" do
    Supervisor.should < Worker
  end

  it "should not allow to lend books for uregistered users" do
    lambda {
        @supervisor.lend(@user, @book)
    }.should raise_error "Cannot lend book for unregistered user"
  end

  it "should be able to lend books for user" do
    User.add(@user)
    Book.add(@book)
    @supervisor.lend(@user, @book)
    @user.should have(1).books_taken
  end

  it "should not allow to extend nonexistend books" do
    lambda {
        book = Book.new "wda", "daw", 1322, "aw", 1
        @supervisor.extend(@user, book)
    }.should raise_error "Cannot extend nonexistent book"
  end

  it "should not allow to take same book" do
    lambda {
        @supervisor.lend(@user, @book)
    }.should raise_error "You already possess that book"
  end

  it "should not allow to take nonexesistend book" do
    lambda {
        book = book = Book.new "wda", "daw", 1322, "aw", 1
        @supervisor.lend(@user, book)
    }.should raise_error "Cannot lend nonexistent book"
  end

  it "should not allow to have more than #{MAX_BOOKS_ALLOWED} books" do
    b1 = Book.new("wda", "daw", 1322, "aw", 1)
    b2 = Book.new("wda", "daw", 1322, "aw", 1)
    b3 = Book.new("wda", "daw", 1322, "aw", 1)
    b4 = Book.new("wda", "daw", 1322, "aw", 1)
    b5 = Book.new("wda", "daw", 1322, "aw", 1)
    Book.add(b1)
    Book.add(b2)
    Book.add(b3)
    Book.add(b4)
    Book.add(b5)
    @supervisor.lend(@user, b1)
    @supervisor.lend(@user, b2)
    @supervisor.lend(@user, b3)
    @supervisor.lend(@user, b4)
    lambda {
        @supervisor.lend(@user, b5)
    }.should raise_error "Cannot take books more than #{MAX_BOOKS_ALLOWED}"
  end

    it "should lend books for users correctly" do
    @book.examples.records[@user].should == Date.today
  end

  it "should be able to extend books period" do
    @supervisor.extend(@user, @book)
    @user.books_taken[@book].should == Date.today
  end

end


