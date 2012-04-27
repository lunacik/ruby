
require './worker.rb'
require 'simplecov'
SimpleCov.start

describe Worker do
  before :all do
    @worker = Worker.new "Paulius", "Dovidauskas", Date.new(1980, 03, 20), 324342, 2000 
  end
  describe "#new" do
    it "should take 5 parameters and return 'Worker' object" do
      @worker.should be_instance_of Worker
    end

    it "should not allow to create worker younger than #{MIN_WORKER_AGE}" do
      lambda {
        Worker.new "Paulius", "Dovidauskas", Date.new(1995, 03, 20), 2312, 2000
      }.should raise_error "Cannot create user younger than #{MIN_WORKER_AGE}"
    end
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
