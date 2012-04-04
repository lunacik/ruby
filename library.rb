
require 'yaml'
require './book'
require './user'
require './supervisor'
require './tools'




class Library
  attr :books, :users, :supervisors
  include IDGenerator

  def initialize(files={})
    @books_file = files[:books]
    @accounts_file = files[:acc]
    @books = @books_file ? YAML::load_file(@books_file) : {}
    @book_ids = @books.keys
    @users = @accounts_file ? YAML::load_file(@accounts_file)[:users] : {}
    @supervisors = @accounts_file ? YAML::load_file(@accounts_file)[:supervisors] : {}
    @acc_ids = @users.keys + @supervisors.keys
  end

  def get_books(category, pattern)
    books = []
    pattern = pattern.to_i if category == :year
    @books.each do |id, book| 
      books.push(id) if eval("book." + category.to_s).upcase.include?(pattern.upcase)
    end
    books
  end

  def add_book(new_book)
    @books[new_id(@book_ids)] = new_book
  end

  def add_acc(type, acc)
    eval(type.to_s)[new_id(@acc_ids)] = acc 
  end 

  def save_books(books_file = false)
    @books_file = books_file || @books_file || "books.yml"
    File.open(@books_file, "w") do |f|
      f.write(YAML::dump @books)
    end
  end

  def save_accounts(acc_file = false)
    @accounts_file = acc_file || @accounts_file || "accounts.yml"
    File.open(@accounts_file, "w") do |f|
        f.write YAML::dump ({:users => @users, :supervisors => @supervisors})
    end
  end

  def connect(who, id, password)
    account = eval("@" + who.to_s)[id]
    raise "Wrong username or password, please try again" if account == nil
    raise "Wrong username or password, please try again" if account.surname != password
    account
  end
end


