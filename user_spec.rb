
require './user'


describe User do
  before :all do
    @user = User.new "Valerij", "Bielskij", 
        Date.new(1990, 4, 29), "lunacik18@gmail.com"
  end

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

  it "should be able to take books from library" do
    @user.take_book(0)
    @user.should have(1).books_taken    
  end

  it "should not allow to have more than 5 books" do
    @user.take_book(1)
    @user.take_book(2)
    @user.take_book(3)
    @user.take_book(4)
    lambda {
        @user.take_book(5)
    }.should raise_error "Cannot take books more than #{MAX_BOOKS_ALLOWED}"
  end

  it "should be able to return books" do
    @user.return_book(4)
    @user.should have(4).books_taken
  end

  it "should not allow to return book which he doesnt poses" do
    lambda {
      @user.return_book(4)
    }.should raise_error "Cannot return nonexistent book"
  end

  it "should be able to extend books period" do
    @user.extend_book(1)
    @user.books_taken[1].should == Date.today
  end

  it "should not allow to extend book which he doesnt poses" do
    lambda {
        @user.extend_book(4)
    }.should raise_error "Cannot extend nonexistent book"
  end

end
