

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
      input = gets.chomp
      case input
        when "1" then
          start_SPS
        when "2" then
          start_US(login(:users))
        when "3" then
          start_SS(login(:supervisors))
        when "4" then
          start_AS(login(:administrators))
        when "5" then
          puts "Good bye..."
          break
        else
          puts "Invalid input! Choose between 1 and 5. Press enter to continue..."
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
    puts "5 - to quit"
  end

  def login(who)
    puts "Enter your id"
    id = gets.to_i
    puts "Enter your password"
    pwd = gets.chomp
    @library.connect(who, id, pwd)
  end

  def start_SPS
    print `clear`
    msg = "1 - to see all books\n2 - to search book\n3 - to disconnect\n"
    print msg
    while true
      input = gets.chomp
      case input
        when "1" then
          printBooks
          puts "Press enter to continue..."
          gets
        when "2" then
          print `clear`
          m = "1 - to search by title\n2 - by author\n3 - by year\n4 - by publisher\n"
          print m
          while true
            inpt = gets.chomp
            case inpt
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
            print m
          end
          puts "Enter search pattern"
          pattern = gets.chomp    
          books = @library.get_books(category, pattern)
          printBooks(books)
          puts "Press enter to continue..."
          gets
        when "3" then
          break
        else
          "Invalid input! Choose between 1 and 3. Press enter to continue..."
          gets
      end
      print `clear`
      print msg
    end      
  end

  def start_US(user)
    puts user.name
  end

  def start_SS(supervisor)
    puts supervisor.name
  end

  def start_AS(administrator)
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
        print book.publisher + "\n"
      end
    end
  end

  def format(string, spaces)
    return string if spaces - string.length <= 0
    string + " " * (spaces - string.length)
  end

end




UI.new
