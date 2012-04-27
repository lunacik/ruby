

class Example
  attr :records
  attr_accessor :count

  def initialize(count)
    @count = count
    @records = {}
  end

  def add(user)
    @records[user] = Date.today
  end

  def delete(user)
    @records.delete(user)
  end

  def extend(user)
    @records[user] = Date.today
  end

  def all
    @records
  end
end

  
