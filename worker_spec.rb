
require './worker.rb'


describe Worker do
  before :all do
    @worker = Worker.new "Paulius", "Dovidauskas", 0, Date.new(1980, 03, 20), 324342, 2000 
  end
  it "should inherit from 'Person'" do
    Worker.should < Person
  end

  describe "#sin" do
    it "should return correct social insurance number" do
      @worker.sin.should == 324342
    end
  end

  describe "#salary" do
    it "should return correct salary" do
      @worker.salary.should == 2000
    end

    it "should allow to change salary" do
      @worker.salary += 100
      @worker.salary.should == 2100
    end
  end 
end
