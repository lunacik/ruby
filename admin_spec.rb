
require './admin'


describe Administrator do
  before :all do
    @admin = Administrator.new("Andrius", "Kasperas", Date.new(1960, 01, 01), 232422)
    @supervisor = Supervisor.new "Paulius", 
        "Dovidauskas", Date.new(1990, 4, 4), 23324, 1000
    @supervisors = [0]
  end

  describe "#new" do
    it "should take 5 parameters and return 'Administrator' object" do
      @admin.should be_instance_of Administrator
    end
  end

  it "should be able to set supervisors salary" do
    @admin.set_salary(@supervisor, 0, @supervisors, 2500)
    @supervisor.salary.should == 2500
  end

  it "should not allow to set negative salary" do
    lambda {
        @admin.set_salary(@supervisor, 0, @supervisors, -1000) 
    }.should raise_error "Cannot set negative salary"
  end

  it "should not allow to set salary for nonexistent supervisor" do
    lambda {
        @admin.set_salary(@supervisor, 1, @supervisors, 1000)
    }.should raise_error "Cannot set salary for nonexistent supervisor"

  end
end
