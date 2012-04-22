
require './collection.rb'
require './user.rb'


describe Collection do

  before :all do
    @user1 = User.new("Valerij", "Bielskij", Date.new(1990, 4, 29), "lunacik@e.lt")
    @user2 = User.new("Eduard", "Bielskij", Date.new(1992, 3, 20), "edka@ep.lt")
  end

  it "should return correct count of items" do
    Collection.count.should == 0
  end

  it "should be able to accept items" do
    Collection.add(2)
    Collection.add("string")
    Collection.count.should == 2
  end

  it "should be able to delete items" do
    Collection.delete(2)
    Collection.count.should == 1
  end

  it "should not allow to delete wrong item" do
    lambda {
      Collection.delete(2)
    }.should raise_error "Cannot delete item which doesnt belongs to collection"
  end

  it "should return all items" do
    Collection.all.should == ["string"]
  end

  it "should return 1 user for search 'val' in users name" do
    Collection.delete("string")
    Collection.add(@user1)
    Collection.add(@user2)
    Collection.find_by_name("val").should have(1).user
  end

  it "should return 2 users for search 'bielskij' in users surname" do
    Collection.find_by_surname("bielskij").should have(2).users
  end

  it "should return 1 user for search '1992' in users birthday" do
    Collection.find_by_birthday("1992").should have(1).user
  end

  it "should return '1st user' for search first 'biel' in users surname" do
    Collection.find_first_by_surname("biel").should == @user1
  end

  describe "#add!" do
    it "should add current object to collection" do
      collection = Collection.new
      collection.add!
      Collection.all.should include(collection)
    end
  end

  it "should allow to delete everything" do
    Collection.clear
    Collection.all.should be_empty
  end
end

