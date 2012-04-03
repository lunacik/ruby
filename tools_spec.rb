
require './tools'


describe "IDGenerator", "#new_id" do
  include IDGenerator

  before :all do
    @ids = []
  end

  it "should return 0 for empty list of id's" do
   new_id(@ids).should == 0
  end

  it "should return 1 for next id" do
    new_id(@ids).should == 1
  end

  it "should return 0 if we remove 0 and add new id" do
    @ids.delete(0)
    new_id(@ids).should == 0
  end

  it "should return 2 if add new id" do
    new_id(@ids).should == 2
  end

  it "should return 3 if we add 2 ids and remove 3'rd" do
    new_id(@ids)
    new_id(@ids)
    @ids.delete(3)
    new_id(@ids).should == 3
  end

  it "should return 5 for next id" do
    new_id(@ids).should == 5
  end

end
