
require './library'

include LIBIS

describe Library do

  before(:all) do
    @lib = Library.new 
    @lib.ids = []
  end

  it "should return 0 for empty list of id's" do
    @lib.get_new_id.should == 0
  end

  it "should return 1 for next user" do
    @lib.get_new_id.should == 1
  end

  it "should return 0 if we remove 0 and add new user" do
    @lib.ids.delete(0)
    @lib.get_new_id.should == 0
  end

  it "should return 2 if add new user" do
    @lib.get_new_id.should == 2
  end

  it "should return 3 if we add 2 users and remove 3'rd" do
    @lib.get_new_id
    @lib.get_new_id
    @lib.ids.delete(3)
    @lib.get_new_id.should == 3
  end

  it "should return 5 for next user" do
    @lib.get_new_id.should == 5
  end

end
