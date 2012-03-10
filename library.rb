
require './reader'
require './worker'
require './book'

class Library
  attr_accessor :readers, :workes, :admins, :books

  def initialize(data_file = "library_data.yml")
    @readers = []
    @workes = []
    @admins = []
    @books = []
    load_data(data_file)
  end

  def load_data(data_file)
    #reading data from file
  end


end
