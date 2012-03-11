
require './reader'
require './supervisor'
require './book'
require './admin'
require 'psych'
require 'yaml'


module LIBIS

class Library
  attr_accessor :readers, :supervisors, :admins, :books, :sec_data, :ids

  def initialize(data_file='lib_data.yml', security_file='sec_data.yml')
    @readers = []
    @supervisors = [] 
    @admins = []
    @books = [] #id => [password, status]
    @data_file = data_file
    @security_file = security_file
    @sec_data = {} 
    load_data(data_file)
    load_sec_data(security_file)
    @ids = @sec_data.keys
  end

  def load_data(data_file=@data_file)
    data = YAML::load_file(data_file)
    @readers = data["readers"]
    @supervisors = data["supervisors"]
    @admins = data["admins"]
    @books = data["books"]
  end

  def save_data(data_file=@data_file)
    File.open(data_file, "w"){|f| YAML.dump({"readers" => @readers, 
        "supervisors" => @supervisors, "admins" => @admins, "books" => @books}, f)} 
  end
  
  def load_sec_data(security_file=@security_file)
    @sec_data = YAML::load_file(security_file)
  end

  def save_sec_data(security_file=@security_file)
    File.open(security_file, "w"){|f| YAML.dump(@sec_data, f)}
  end

  def get_new_id
    if @ids == []
      @ids.push(0)
      0
    else
      for id in 0..@ids.max + 1 do
        if not @ids.include?(id)
          @ids.push(id)
          return id
        end
      end
    end
  end
  
end

end # module
