
require './book'


describe Book do
  before :all do
    @book = Book.new "Baltoji iltis", "Jack London", 1906, "Mano knyga"
  end

  describe "#new" do
    it "should take four parameters and return new Book object" do
      @book.should be_instance_of Book
    end
  end

  describe "#title" do
    it "should return correct title" do
      @book.title.should == "Baltoji iltis"
    end
  end

  describe "#author" do
    it "should return correct author" do
      @book.author.should == "Jack London"
    end
  end

  describe "#year" do
    it "should return correct year" do
      @book.year.should == 1906
    end
  end

  describe "#publisher" do
    it "should return correct publisher" do
      @book.publisher.should == "Mano knyga"
    end
  end

end
