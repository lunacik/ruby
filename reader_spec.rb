
require './reader'


describe Reader do
  before(:all) do
    @reader = Reader.new("Valerij", "Bielskij", \
        Date.new(1990, 04, 29), 0, "lunacik18@gmail.com")
  end

  it "should inherit from 'Person'" do
    Reader.should < Person
  end

  it "birthday should be on 1990-04-29" do
    @reader.birthday.should == Date.new(1990, 04, 29)
  end

  it "email should be 'lunacik18@gmail.com'" do
    @reader.email.should == "lunacik18@gmail.com"
  end

  it "should have empty hash of books" do
  end

end

