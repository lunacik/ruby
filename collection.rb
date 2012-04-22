

class Collection
  @collection = []

  def add!
    self.class.add(self)
  end

  def self.add(*items)
    @collection.push(*items)
  end

  def self.count
    @collection.size
  end

  def self.delete(item)
    if not @collection.include?(item)
      raise "Cannot delete item which doesnt belongs to collection"
    end
    @collection.delete(item)
  end

  def self.delete_by_id(id)
    item = @collection.find {|item| item.id == id}
    raise "Cannot delete item which doesnt belongs to collection" if item == nil
    @collection.delete(item)
  end

  def self.all
    @collection
  end

  def self.clear
    @collection.clear  
  end

  def self.find_first_by(attr, value)
    @collection.find do |item| 
      val = item.instance_variable_get(("@" + attr).to_sym).to_s.upcase
      val.include?(value.to_s.upcase)
    end
  end

  def self.find_by(attr, value)
    @collection.select do |item| 
      val = item.instance_variable_get(("@" + attr).to_sym).to_s.upcase
      item if val.include?(value.to_s.upcase)
    end
  end

  def self.method_missing(name, *args)
    return find_by(Regexp.last_match(1),  args[0]) if name =~ /find_by_(.+)/
    return find_first_by(Regexp.last_match(1),  args[0]) if name =~ /find_first_by_(.+)/
    raise NoMethodError
  end
  
  def self.==(other)
    self.instance_variables.each do |ivar| 
      return false if instance_variable_get(ivar) != other.instance_variable_get(ivar)
    end
  end
end
