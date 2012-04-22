
require 'yaml'
require './book'
require './user'
require './supervisor'
require './admin'
require './tools'



class Library
  def initialize(files={})
    @books_file = files[:books]
    @accounts_file = files[:accounts]
    *books = @books_file ? YAML::load_file(@books_file) : nil
    *users = @accounts_file ? YAML::load_file(@accounts_file)[:users] : nil
    *supervisors = @accounts_file ? YAML::load_file(@accounts_file)[:supervisors] : nil
    *administrators = @accounts_file ? YAML::load_file(@accounts_file)[:administrators] : nil
    Book.add(*books) if books.first
    User.add(*users) if users.first
    Supervisor.add(*supervisors) if supervisors.first
    Administrator.add(*administrators) if administrators.first
    User.all.collect {|item| Person.ids.push item.id}
    Supervisor.all.collect {|item| Person.ids.push item.id}
    Administrator.all.collect {|item| Person.ids.push item.id}
  end

  def save_books(books_file = false)
    @books_file = books_file || @books_file || "books.yml"
    File.open(@books_file, "w") do |f|
      f.write(YAML::dump Book.all)
    end
  end

  def save_accounts(acc_file = false)
    @accounts_file = acc_file || @accounts_file || "accounts.yml"
    File.open(@accounts_file, "w") do |f|
      f.write YAML::dump ({
          :users => User.all, :supervisors => Supervisor.all,
          :administrators => Administrator.all
      })
    end
  end

  def connect(id, password)
    account = User.find_first_by_id(id) || Supervisor.find_first_by_id(id) || Administrator.find_first_by_id(id)
    raise "Wrong username or password, please try again" if account == nil
    raise "Wrong username or password, please try again" if account.surname != password
    account
  end
end


