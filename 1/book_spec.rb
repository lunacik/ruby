
require './book'
require 'simplecov'
SimpleCov.start

describe Book do
  before :all do
    @book = Book.new "Baltoji iltis", "Jack London", 1906, "Mano knyga", 3
  end

  describe "#new" do
    it "should take five parameters and return new Book object" do
      @book.should be_instance_of Book
    end

    it "should not allow to create book with year greater than current" do
      lambda {
          Book.new "Mike", "Pukuotukas", Date.today.year + 1, "knygynas", 3
      }.should raise_error "Cant create book with year greater than current"
    end

    it "should not allow to create book with empty title" do
      lambda {
          Book.new "", "Pukuotukas", 1900, "knygynas", 3
      }.should raise_error "Cant create book without title"
    end 

    it "should not allow to create book with empty author" do
      lambda {
          Book.new "Mike", "", 1900, "knygynas", 3
      }.should raise_error "Cant create book without author"
    end  

    it "should not allow to create book with empty publisher" do
      lambda {
          Book.new "Mike", "Pukuotukas", 1900, "", 3
      }.should raise_error "Cant create book without publisher"
    end

    it "should not allow to create book with less than one example" do
      lambda {
        Book.new "Mike", "Pukuotukas", 1900, "KVM", 0
      }.should raise_error "Book cannot have less than one example"
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
  
  it "should inherit from 'Collection'" do
    Book.should < Collection
  end

  it "should have examples" do
    @book.examples.should be_instance_of Example
  end

  it "should return correct examples count" do
    @book.examples.count.should == 3
  end

  it "examples count should be increased if same books is added" do
    Book.add(@book)
    Book.add(@book)
    @book.examples.count.should == 6
  end

end


