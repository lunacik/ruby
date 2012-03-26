
require './book'


describe Book do
  before :all do
    @book = Book.new "Baltoji iltis", "Jack London", 1906, "Mano knyga"
  end

  describe "#new" do
    it "should take four parameters and return new Book object" do
      @book.should be_instance_of Book
    end

    it "should not allow to create book with year greater than current" do
      lambda {
          Book.new "Mike", "Pukuotukas", Date.today.year + 1, "knygynas"
      }.should raise_error "Cant create book with year greater than current"
    end

    it "should not allow to create book with empty title" do
      lambda {
          Book.new "", "Pukuotukas", 1900, "knygynas"
      }.should raise_error "Cant create book without title"
    end 

    it "should not allow to create book with empty author" do
      lambda {
          Book.new "Mike", "", 1900, "knygynas"
      }.should raise_error "Cant create book without author"
    end  

    it "should not allow to create book with empty publisher" do
      lambda {
          Book.new "Mike", "Pukuotukas", 1900, ""
      }.should raise_error "Cant create book without publisher"
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
