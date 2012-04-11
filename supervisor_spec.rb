
require './supervisor'
require './library'


describe Supervisor do
  before :all do
    @supervisor = Supervisor.new "Paulius", "Dovidauskas", 
        Date.new(1990, 4, 4), 23324, 1000

    @user = User.new "Valerij", "Bielskij", 
          Date.new(1990, 4, 29), "lunacik18@gmail.com"

    @user_id = 0
    @book_id = 0

    @books_examples = {
      @book_id => {:count => 3, :who => {}},
      1 => {:count => 1, :who => {}},
      2 => {:count => 1, :who => {}},
      3 => {:count => 1, :who => {}},
      4 => {:count => 1, :who => {}},
      5 => {:count => 1, :who => {}}
    }

    @users = [0]

    @library = Library.new
  end

  describe "#new" do
    it "should take 5 parameters and return 'Supervisor' object" do
      @supervisor.should be_instance_of Supervisor
    end
  end

  it "should inherit from 'Worker'" do
    Supervisor.should < Worker
  end

  it "should be able to lend books for user" do
    @supervisor.lend(@books_examples, @users, @book_id, @user, @user_id)
    @user.should have(1).books_taken
  end

  it "should lend books for users correctly" do
    @books_examples[@book_id][:who][@user_id].should == Date.today
  end

  it "should not allow to take same book" do
    lambda {
        @supervisor.lend(@books_examples, @users, @book_id, @user, @user_id)
    }.should raise_error "You already possess that book"
  end

  it "should not allow to take nonexesistend book" do
    lambda {
        @supervisor.lend(@books_examples, @users, 6, @user, @user_id)
    }.should raise_error "Cannot lend nonexistent book"
  end

  it "should not allow to have more than #{MAX_BOOKS_ALLOWED} books" do
    @supervisor.lend(@books_examples, @users, 1, @user, @user_id)
    @supervisor.lend(@books_examples, @users, 2, @user, @user_id)
    @supervisor.lend(@books_examples, @users, 3, @user, @user_id)
    @supervisor.lend(@books_examples, @users, 4, @user, @user_id)
    lambda {
        @supervisor.lend(@books_examples, @users, 5, @user, @user_id)
    }.should raise_error "Cannot take books more than #{MAX_BOOKS_ALLOWED}"
  end

  it "should be able to extend books period" do
    @supervisor.extend(@books_examples, @book_id, @user, @user_id)
    @user.books_taken[@book_id].should == Date.today
  end

  it "should not allow to extend nonexistend books" do
    lambda {
        @supervisor.extend(@books_examples, 6, @user, @user_id)
    }.should raise_error "Cannot extend nonexistent book"
  end

  it "should not allow to lend books for uregistered users" do
    lambda {
        @supervisor.lend(@books_examples, @users, 1, @user, 7)
    }.should raise_error "Cannot lend book for unregistered user"
  end
end


