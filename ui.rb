

require './book'
require './user'
require './supervisor'
require './library'



class UI
  def initialize
    @library = Library.new ({:books => "books.yml", :acc => "accounts.yml"})
    loopMenu
  end

  def loopMenu
    print `clear`
    puts "Welcome to the Library!"
    printMenu
    while true
      begin
        case gets.chomp
          when "1" then
            start_SPS
          when "2" then
            start_US(login(:users))
          when "3" then
            start_SS(login(:supervisors))
          when "4" then
            start_AS(login(:administrators))
          when "5" then
            @library.save_accounts
            @library.save_books
          when "6" then
            puts "Good bye..."
            break
          else
            puts "Invalid input! Choose between 1 and 5. Press enter to continue..."
            gets
        end
      rescue Exception => e
        puts e
        puts "Press enter to continue..."
        gets
      end
      print `clear`
      printMenu
    end
  end

  def printMenu
    puts "1 - to enter spectator mode"
    puts "2 - to enter reader mode"
    puts "3 - to enter supervisor mode"
    puts "4 - to enter administrator mode"
    puts "5 - to save changes"
    puts "6 - to quit"
  end

  def login(who)
    puts "Enter your username"
    id = gets.to_i
    puts "Enter your password"
    pwd = gets.chomp
    @library.connect(who, id, pwd)
  end

  def start_SPS
    print `clear`
    msg = "1 - to see all books in library\n2 - to search book\n3 - to disconnect\n"
    print msg
    while true
      case gets.chomp
        when "1" then
          printBooks
          puts "Press enter to continue..."
          gets
        when "2" then
          seach_book
        when "3" then
          break
        else
          print "Invalid input! Choose between 1 and 3. Press enter to continue..."
          gets
      end
      print `clear`
      print msg
    end      
  end

  def start_US(user_id)
    user = @library.users[user_id]
    print `clear`
    msg = "1 - to see all books in library\n2 - to search book\n3 - to extend book\n4 - to return book\n5 - to see taken books\n6 - to diconnect\n"
    print msg
    while true
      case gets.chomp
      when "1" then
        printBooks
        puts "Press enter to continue..."
        gets
      when "2" then
        search_book
      when "3" then
        puts "Enter book id"
        book_id = gets.to_i
        user.extend(@library.books_examples, book_id, user_id)
        puts "Press enter to continue..."
        gets
      when "4" then
        puts "Enter book id"
        book_id = gets.to_i
        user.return(@library.books_examples, book_id, user_id)
        puts "Press enter to continue..."
        gets
      when "5" then
        printBooks(user.books_taken.keys)
        puts "Press enter to continue..."
        gets
      when "6" then
        break
      else
        puts "Invalid input! Choose between 1 and 6. Press enter to continue..."
        gets
      end
      print `clear`
      puts msg
    end
  end

  def start_SS(supervisor_id)
    supervisor = @library.supervisors[supervisor_id]
    msg = "1 - to see all books in library\n2 - to search book\n3 - to remove user\n4 - to add new user\n5 - to lend a book\n6 - to see all users\n7 - to disconnect"
    while true
      print `clear`
      puts msg
      case gets.chomp
        when "1" then
          printBooks
          puts "Press enter to continue..."
          gets
        when "2" then
          search_book
        when "3" then
          puts "Enter user id"
          user_id = gets.to_i
          @library.users.delete(user_id)
          puts "Press enter to continue..."
          gets
        when "4" then
          puts "Enter name"
          name = gets.chomp
          puts "Enter surname"
          surname = gets.chomp
          puts "Enter birthday (yyyy-mm-dd)"
          birthday = Date.parse(gets)
          puts "Enter email"
          email = gets.chomp
          user = User.new(name, surname, birthday, email)
          @library.add_acc(:users, user)
          puts "Press enter to continue..."
          gets
        when "5" then
          puts "Enter user id"
          user_id = gets.to_i
          puts "Enter book id"
          book_id = gets.to_i
          user = @library.users[user_id]
          supervisor.lend(@library.books_examples, @library.users, book_id, user, user_id)
          puts "Press enter to continue..."
          gets
        when "6" then
          print `clear`
          if @library.users == {}
            puts "No records"
          else
            puts "ID |   Name   |   Surname    |     Birthday    |         Email" 
            @library.users.each do |id, user|
              print "#{id}   "
              print format(user.name, 15)
              print format(user.surname, 15)
              print user.birthday.to_s + "       "
              puts user.email
            end
          end
          puts "Press enter to continue..."
          gets
        when "7" then
          break
        else
          puts "Invalid input! Choose between 1 and 7. Press enter to continue..."
          gets
      end
      print `clear`
      puts msg
    end
  end

  def start_AS(administrator_id)
    administrator = @library.administrators[administrator_id]
    msg = "1 - to see all supervisors\n2 - to add new supervisor\n3 - to remove supervisor\n4 - to change supervisors salary\n5 - to disconnect"
    while true
      print `clear`
      puts msg
      case gets.chomp
        when "1" then
          print `clear`
          if @library.supervisors == {}
            puts "No records"
          else
            puts "ID |   Name   |   Surname    |     Birthday    |       SIN     |        Salary" 
            @library.supervisors.each do |id, supervisor|
              print "#{id}   "
              print format(supervisor.name, 15)
              print format(supervisor.surname, 15)
              print supervisor.birthday.to_s + "       "
              print format(supervisor.sin.to_s, 20)
              puts supervisor.salary
            end
          end
          puts "Press enter to continue..."
          gets
        when "2" then
          puts "Enter name"
          name = gets.chomp
          puts "Enter surname"
          surname = gets.chomp
          puts "Enter birthday (yyyy-mm-dd)"
          birthday = Date.parse(gets)
          puts "Enter social insurance number"
          sin = gets.to_i
          supervisor = Supervisor.new(name, surname, birthday, sin)
          @library.add_acc(:supervisors, supervisor)
          puts "Press enter to continue..."
          gets
        when "3" then
          puts "Enter supervisor id"
          supervisor_id = gets.to_i
          @libarary.supervisors.delete(supervisor_id)
          puts "Press enter to continue..."
          gets
        when "4" then
          puts "Enter supervisor id"
          supervisor_id = gets.to_i
          supervisor = @library.supervisors[supervisor_id]
          puts "Enter new salary"
          salary = gets.to_i
          administrator.set_salary(supervisor, supervisor_id, @library.supervisors, salary)
          puts "Press enter to continue..."
          gets
        when "5" then
          break
        else
          puts "Invalid input! Choose between 1 and 5. Press enter to continue..."
          gets
        end
    end
  end

  def printBooks(books_ids=@library.books.keys)
    if books_ids == []  
      puts "No records"
    else
      puts "ID |       Title       |       Author        | Year |  Publisher"
      books_ids.each do |id|
        book = @library.books[id]
        print "#{id}    "  
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

  def seach_book
    print `clear`
    msg = "1 - to search by title\n2 - by author\n3 - by year\n4 - by publisher\n"
    print m
    while true
      case gets.chomp
        when "1"
          category = :title
          break
        when "2"
          category = :author
          break
        when "3"
          category = :year
          break
        when "4"
          category = :publisher
          break
        else
          puts "Invalid input! Choose between 1 and 3. Press enter to continue..."
          gets
      end
      print `clear`
      print msg
    end
    puts "Enter search pattern"
    pattern = gets.chomp    
    books = @library.get_books(category, pattern)
    printBooks(books)
    puts "Press enter to continue..."
    gets
  end
end



UI.new
