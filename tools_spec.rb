
require './tools'
require './collection'
require './spec_helper.rb'


class Temp < Collection
  include IDGenerator
  @collection = []

  attr :id

  def initialize
    @id = new_id
  end
end



describe "IDGenerator", "#new_id" do
  include IDGenerator

  it "id should be 0 for first item" do
    Temp.new.should have_id_equal 0 
  end

  it "id should be 1 for next item" do
    Temp.new.should have_id_equal 1
  end

  it "id should be 0 if delete first item" do
    Temp.delete(Temp.find_first_by_id(0))
    Temp.new.should have_id_equal 0
  end

  it "id should be 2 for next item" do
    Temp.new.should have_id_equal 2
  end

end
