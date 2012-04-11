
require './user'


describe User do
  before :all do
    @user = User.new "Valerij", "Bielskij", 
        Date.new(1990, 4, 29), "lunacik18@gmail.com"
    
    @book_id = 0
    @user_id = 0
 
    @user.books_taken[@book_id] = Date.today

    @books_examples = {
      0 => {:count => 3, :who => {}},
      1 => {:count => 1, :who => {}},
      2 => {:count => 1, :who => {}},
      3 => {:count => 1, :who => {}},
      4 => {:count => 1, :who => {}},
      5 => {:count => 1, :who => {}}
    }
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

  it "should be able to return books back" do
    @user.return(@books_examples, @book_id,  @user_id)
    @books_examples[@book_id][:who][@user_id].should be_nil
  end

  it "should not allow to return nonexistend books" do
    lambda {
        @user.return(@books_examples, 6,  @user_id)
    }.should raise_error "Cannot return nonexistent book"
  end

  it "should take books back correctly" do
    @user.books_taken[@book_id].should be_nil
  end

end
