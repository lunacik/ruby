
require './admin'


describe Administrator do
  before :all do
    @admin = Administrator.new("Andrius", "Kasperas", Date.new(1960, 01, 01), 232422)
    @supervisor = Supervisor.new "Paulius", 
        "Dovidauskas", Date.new(1990, 4, 4), 23324, 1000
  end

  describe "#new" do
    it "should take 5 parameters and return 'Administrator' object" do
      @admin.should be_instance_of Administrator
    end
  end

  it "should be able to set supervisors salary" do
    Supervisor.add(@supervisor)
    @admin.set_salary(@supervisor, 2500)
    @supervisor.salary.should == 2500
  end

  it "should not allow to set negative salary" do
    lambda {
        @admin.set_salary(@supervisor, -1000) 
    }.should raise_error "Cannot set negative salary"
  end

  it "should not allow to set salary for nonexistent supervisor" do
    lambda {
        supervisor = Supervisor.new "awd", "daw", Date.new(1985, 1, 1), 2313, 2000
        @admin.set_salary(supervisor, 1000)
    }.should raise_error "Cannot set salary for nonexistent supervisor"
  end
end
