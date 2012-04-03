
require './user'


describe User do
  before :all do
    @user = User.new "Valerij", "Bielskij", 0, 
        Date.new(1990, 4, 29), "lunacik18@gmail.com"
  end

  it "should inherit from person" do
    User.should < Person
  end

  describe "#new" do
    it "should take 5 parameters and return 'User' object" do
      @user.should be_instance_of User
    end

    it "should not allow to create user younger than #{MIN_USER_AGE}" do
      lambda {
          User.new "Valerij", "Bielskij", 0, Date.new(1999, 4, 3), "e@mail.com"
      }.should raise_error "Cannot create user younger than #{MIN_USER_AGE}"
    end
  end

  describe "#email" do
    it "should return correct email" do
      @user.email.should == "lunacik18@gmail.com"
    end
  end

  it "should be able to take books from library" do
      
  end


end
