
require 'yaml'
require './book'
require './user'
require './supervisor'
require './admin'
require './tools'




class Library
  attr :books, :users, :supervisors, :administrators, :books_examples
  include IDGenerator

  def initialize(files={})
    @books_file = files[:books]
    @accounts_file = files[:acc]
    @books = @books_file ? YAML::load_file(@books_file)[:books] : {}
    @books_examples = @books_file ? YAML::load_file(@books_file)[:examples] : {}
    @book_ids = @books.keys
    @users = @accounts_file ? YAML::load_file(@accounts_file)[:users] : {}
    @supervisors = @accounts_file ? YAML::load_file(@accounts_file)[:supervisors] : {}
    @administrators = @accounts_file ? YAML::load_file(@accounts_file)[:administrators] : {}
    @acc_ids = @users.keys + @supervisors.keys + @administrators.keys
  end

  def get_books(category, pattern)
    pattern = pattern.to_i if category == :year
    @books.select do |id, book| 
      id if eval("book." + category.to_s).upcase.include?(pattern.upcase)
    end.keys
  end

  def add_book(new_book, count)
    new_book_id = new_id(@book_ids)
    @books[new_book_id] = new_book
    @books_examples[new_book_id] = {}
    @books_examples[new_book_id][:count] = count
    @books_examples[new_book_id][:who] = {}
  end

  def add_acc(type, acc)
    eval(type.to_s)[new_id(@acc_ids)] = acc 
  end 

  def remove_acc(type, acc_id)
    eval(type.to_s).delete(acc_id)
  end

  def save_books(books_file = false)
    @books_file = books_file || @books_file || "books.yml"
    File.open(@books_file, "w") do |f|
      f.write(YAML::dump ({:books => @books, :examples => @books_examples}))
    end
  end

  def save_accounts(acc_file = false)
    @accounts_file = acc_file || @accounts_file || "accounts.yml"
    File.open(@accounts_file, "w") do |f|
        f.write YAML::dump ({
            :users => @users, :supervisors => @supervisors,
            :administrators => @administrators
        })
    end
  end

  def connect(who, id, password)
    account = eval("@" + who.to_s)[id]
    raise "Wrong username or password, please try again" if account == nil
    raise "Wrong username or password, please try again" if account.surname != password
    id
  end
end


