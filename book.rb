
require 'date'
require './tools'
require './collection'
require './example'


class Book < Collection
  attr :title, :author, :year, :publisher, :id
  attr_accessor :examples
  @collection = []

  include IDGenerator  

  def initialize(title, author, year, publisher, count)
    raise "Cant create book with year greater than current" if year > Date.today.year
    raise "Cant create book without title" if title.empty?
    raise "Cant create book without author" if author.empty?
    raise "Cant create book without publisher" if publisher.empty?
    raise "Book cannot have less than one example" if count < 1
    @title = title
    @author = author
    @year = year
    @publisher = publisher
    @examples = Example.new(count)
    @id = new_id
  end
   
  def self.add(*items)
    items.each {|item| Book.add2(item)}
  end

  def self.add2(new_item)
    Book.all.each do |item|
      if item == new_item
        item.examples.count += new_item.examples.count
        return
      end
    end
    @collection.push(new_item)
  end

  def ==(other)
    self.instance_variables.each do |ivar|
      self_ivar = self.instance_variable_get(ivar) 
      other_ivar = other.instance_variable_get(ivar) 
      return false if self_ivar != other_ivar and self_ivar != :@examples
    end
  end
end
