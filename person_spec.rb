
require './person'


describe Person do
  before(:all) do
    @person = Person.new("Valerij", "Bielskij", Date.new(1990, 04, 29), 0)  
  end

  it "name should be 'Valerij'" do
    @person.name.should == "Valerij"
  end

  it "surname should be Bielskij" do
    @person.surname.should == "Bielskij"
  end

  it "birthday should be on 1990-04-29" do
    @person.birthday == Date.new(1990, 04, 29)
  end

  it "id should be equal 0" do
    @person.id.should == 0
  end

end
