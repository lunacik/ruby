
require './person'


describe Person do
  before :all do
    @person = Person.new "Valerij", "Bielskij", Date.new(1990, 4, 29)
  end
  describe "#new" do
    it "should take 3 parameters and return 'Person' object" do
      @person.should be_instance_of Person
    end

    it "should not allow to initialize person with empty name" do
      lambda {
          Person.new "", "Bielskij", Date.new(1990, 4, 29)
      }.should raise_error "Cannot create person without name"
    end

    it "should not allow to initialize person with empty surname" do
      lambda {
          Person.new "Valerij", "", Date.new(1990, 4, 29)
      }.should raise_error "Cannot create person without surname"
    end
  end
  
  describe "#name" do
      it "should return correct name" do
        @person.name.should == "Valerij"
      end
  end

  describe "#surname" do
    it "should return correct surname" do
      @person.surname.should == "Bielskij"
    end
  end

  describe "#birthday" do
    it "should return correct birthday" do
      @person.birthday.should == Date.new(1990, 4, 29)
    end
  end
end
