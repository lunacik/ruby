
require 'date'
require './collection'
require './tools'


class Person < Collection
  attr :name, :surname, :birthday, :id

  @collection = []
  @@ids = [] 
  include IDGenerator

  def initialize(name, surname, birthday)
    raise "Cannot create person without name" if name == ""
    raise "Cannot create person without surname" if surname == ""
    @name = name
    @surname = surname
    @birthday = birthday
    @id = new_id(self.class.ids)
    self.class.ids.push(@id)
  end

  def self.ids
    @@ids
  end

  def self.delete(item)
    if not @collection.include?(item)
      raise "Cannot delete item which doesnt belongs to collection"
    end
    @@ids.delete(item.id)
    @collection.delete(item)
  end


end
