
require './supervisor'


describe Supervisor do
  it "should inherit from 'Worker'" do
    Supervisor.should < Worker
  end
end
