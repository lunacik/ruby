

require './book'
require './user'
require './supervisor'
require './library'



class Controller
  def initialize
    @library = Library.new({:books => "books.yml", :accounts => "accounts.yml"})
    loopMenu
  end

  def print_clear(message)
    print `clear`
    puts message
  end

  def loopMenu
    while true
      begin
        print_clear "Welcome to the Library!"
        printMenu
        case gets.chomp
          when "1" then
            start_SPS
          when "2" then
            puts "Enter your username"
            id = gets.to_i
            puts "Enter your password"
            pwd = gets.chomp
            account = @library.connect(id, pwd)
            if account.instance_of?(User)
              start_US(account)
            elsif account.instance_of?(Supervisor)
              start_SS(account)
            else
              start_AS(account)
            end 
          when "3" then
            puts "Good bye..."
            break
          else
            invalid_input(3)
        end
      rescue Exception => e
        puts e
        idle
      end
    end
  end

  def printMenu
    puts "1 - to enter spectator mode"
    puts "2 - to login"
    puts "3 - to quit"
  end


  def start_SPS
    while true
      print_clear "1 - to see all books in library\n2 - to search book\n3 - to disconect"
      case gets.chomp
        when "1" then
          print_books
          idle
        when "2" then
          search_book
        when "3" then
          break
        else
          invalid_input(3)
      end
    end      
  end

  def start_US(user)
    while true
      print_clear "1 - to see all books in library\n2 - to search book\n3 - to extend book"
      puts "4 - to return book\n5 - to see taken books\n6 - to disconnect"
      case gets.chomp
        when "1" then
          print_books
          idle
        when "2" then
          search_book
        when "3" then
          puts "Enter book id"
          book_id = gets.to_i
          book = Book.find_first_by_id(book_id)
          user.extend(book)
          idle
        when "4" then
          puts "Enter book id"
          book_id = gets.to_i
          book = Book.find_first_by_id(book_id)
          user.return(book)
          idle
        when "5" then
          print_books(user.books_taken.keys)
          idle
        when "6" then
          break
        else
          invalid_input(6)
      end
    end
  end

  def start_SS(supervisor)
    while true
      print_clear "1 - to see all books in library\n2 - to search book"
      puts "3 - to remove user\n4 - to add new user\n5 - to lend a book"
      puts "6 - to see all users\n7 - to add new book\n8 - to disconnect"
      case gets.chomp
        when "1" then
          print_books
          idle
        when "2" then
          search_book
        when "3" then
          puts "Enter user id"
          user_id = gets.to_i
          User.delete_by_id(user_id)
          idle
        when "4" then
          puts "Enter name"
          name = gets.chomp
          puts "Enter surname"
          surname = gets.chomp
          puts "Enter birthday (yyyy-mm-dd)"
          birthday = Date.parse(gets)
          puts "Enter email"
          email = gets.chomp
          User.new(name, surname, birthday, email).add!
          idle
        when "5" then
          puts "Enter user id"
          user_id = gets.to_i
          puts "Enter book id"
          book_id = gets.to_i
          user = User.find_first_by_id(user_id)
          book = Book.find_first_by_id(book_id)
          supervisor.lend(user, book)
          idle
        when "6" then
          if User.all.empty?
            print_clear "No records"
          else
            print_clear "ID |   Name   |   Surname    |     Birthday    |         Email" 
            User.all.each do |user|
              print "#{user.id}   "
              print format(user.name, 15)
              print format(user.surname, 15)
              print user.birthday.to_s + "       "
              puts user.email
            end
          end
          idle
        when "7" then 
          puts "Enter name"
          name = gets.chomp
          puts "Enter author"
          author = gets.chomp
          puts "Enter year"
          year = gets.to_i
          puts "Enter publisher"
          publisher = gets.chomp
          puts "Enter the number of copies"
          count = gets.to_i
          Book.new(name, author, year, publisher, count).add!
          idle
        when "8" then
          break
        else
          invalid_input(8)
      end
    end
  end

  def start_AS(administrator)
    while true
      print_clear "1 - to see all supervisors\n2 - to add new supervisor"
      puts "3 - to remove supervisor\n4 - to change supervisors salary"
      puts "5 - to save everything \n6 - to disconnect"
      case gets.chomp
        when "1" then
          if Supervisor.all.empty?
            print_clear "No records"
          else
            print_clear "ID |   Name   |   Surname    |     Birthday    |       SIN     |        Salary" 
            Supervisor.all.each do |supervisor|
              print "#{supervisor.id}   "
              print format(supervisor.name, 15)
              print format(supervisor.surname, 15)
              print supervisor.birthday.to_s + "       "
              print format(supervisor.sin.to_s, 20)
              puts supervisor.salary
            end
          end
          idle
        when "2" then
          puts "Enter name"
          name = gets.chomp
          puts "Enter surname"
          surname = gets.chomp
          puts "Enter birthday (yyyy-mm-dd)"
          birthday = Date.parse(gets)
          puts "Enter social insurance number"
          sin = gets.to_i
          Supervisor.new(name, surname, birthday, sin).add!
          idle
        when "3" then
          puts "Enter supervisor id"
          supervisor_id = gets.to_i
          Supervisor.delete_by_id(supervisor_id)
          idle
        when "4" then
          puts "Enter supervisor id"
          supervisor_id = gets.to_i
          supervisor = Supervisor.find_first_by_id(supervisor_id)
          puts "Enter new salary"
          salary = gets.to_f
          administrator.set_salary(supervisor, salary)
          idle
        when "5" then
          @library.save_books
          @library.save_accounts
          idle
        when "6" then
          break
        else
          invalid_input(6)
        end
    end
  end

  def print_books(books = Book.all)
    if books.empty?
      print_clear "No records"
    else
      print_clear "ID |       Title       |       Author        | Year |  Publisher"
      books.each do |book|
        print "#{book.id}    "  
        print format(book.title, 20)
        print format(book.author, 22)
        print book.year, "    "
        puts book.publisher
      end
    end
  end

  def format(string, spaces)
    return string if spaces - string.length <= 0
    string + " " * (spaces - string.length)
  end

  def search_book
    while true
      print_clear "1 - to search by title\n2 - by author\n3 - by year\n4 - by publisher\n"
      case gets.chomp
        when "1"
          print_books(Book.find_by_title(get_pattern))
          break
        when "2"
          print_books(Book.find_by_author(get_pattern))
          break
        when "3"
          print_books(Book.find_by_year(get_pattern))
          break
        when "4"
          print_books(Book.find_by_publisher(get_pattern))
          break
        else
          invalid_input(4)
      end
    end

    idle
  end
  
  def get_pattern
    puts "Enter search pattern"
    gets.chomp    
  end

  def idle
    puts "Press enter to continue..."
    gets
  end

  def invalid_input(range)
    puts "Invalid input! Choose between 1 and #{range}. Press enter to continue..."
    gets
  end
end



Controller.new
