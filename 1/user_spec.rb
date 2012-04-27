
require './user'
require 'simplecov'
SimpleCov.start

describe User do
  before :all do
    @user = User.new "Valerij", "Bielskij", 
      Date.new(1990, 4, 29), "lunacik18@gmail.com"
    
    @book = Book.new "Knyga", "kazkas", 2000, "NzN", 5
    @user.books_taken[@book] = Date.today
    @book.examples.records[@user] = Date.today
  end

#=begin
  it "should inherit from person" do
    User.should < Person
  end

  describe "#new" do
    it "should take 4 parameters and return 'User' object" do
      @user.should be_instance_of User
    end

    it "should not allow to create user younger than #{MIN_USER_AGE}" do
      lambda {
          User.new "Valerij", "Bielskij", Date.new(1999, 4, 3), "e@mail.com"
      }.should raise_error "Cannot create user younger than #{MIN_USER_AGE}"
    end
  end

  describe "#email" do
    it "should return correct email" do
      @user.email.should == "lunacik18@gmail.com"
    end
  end

  it "books examples records should be correct" do
    @book.examples.should have(1).records
  end

  it "should be able to return books back" do
    @user.return(@book)
    @user.should have(0).books_taken
  end

  it "should not allow to return nonexistend books" do
    lambda {
        @user.return(Book.new("wd", "dwa", 1900, "awd", 3))
    }.should raise_error "Cannot return nonexistent book"
  end

  it "should return books correctly" do
    @book.examples.should have(0).records
  end
#=end
end

