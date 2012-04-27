
require './library'
require './spec_helper'
require 'simplecov'
SimpleCov.start

describe Library do
  before :all do
    Book.clear
    User.clear
    Supervisor.clear
    Administrator.clear
    Person.ids.clear
    @bt = "books_test.yml"
    @at = "acc_test.yml"

    Book.new("Baltoji iltis", "Jack London", 1906, "Mano knyga", 4).add!
    Book.new("Heroinas", "Melvin Burgess", 1995, "Baltos lankos", 2).add!
    Book.new("Alchemikas", "Paulo Coehlo", 1995, "Mano knyga", 1).add!
    Book.new("Kelias Atgal", "Erich Maria Remarque", 1930, "VVL", 5).add!
    Book.new("Kelias Namo", "Ghost Writer", 2012, "VKL", 3).add!

    User.new("Valerij", "Bielskij", Date.new(1990, 4, 29), "lunacik@epastas.lt").add!
    User.new("Eduard", "Bielskij", Date.new(1992, 3, 20), "edka@one.lt").add!
        
    Supervisor.new("Paulius", "Dovidauskas", Date.new(1980, 03, 20), 2353434).add!

    Administrator.new("Andrius", "Kasperas", Date.new(1960, 01, 01), 232422).add!

    File.open @bt, "w" do |f|
      f.write YAML::dump Book.all
    end

    File.open @at, "w" do |f|
      f.write YAML::dump ({
        :users => User.all, :supervisors => Supervisor.all,
        :administrators => Administrator.all
      })
    end

    Book.clear
    User.clear
    Supervisor.clear
    Administrator.clear
  end

  before :all do
    @library = Library.new({:books => @bt, :accounts => @at})
  end

  describe "#new" do
    context "with yaml file parameter" do
      it "should have 5 books" do
        Book.count.should == 5
      end

      it "should have 1 supervisor" do
        Supervisor.count.should == 1
      end
    end
  end

  it "should save books correctly" do
    @library.should save_books_correctly
  end

  it "should save accounts correctly" do
    @library.save_accounts("accounts.yml")
    users = {:users => User.all} 
    User.clear
    Supervisor.clear
    Administrator.clear
    Library.new :accounts => "accounts.yml"
    users.should == {:users =>User.all}
  end

  it "should allow to connect to information system for users" do
    @library.connect(0, "Bielskij").should be_instance_of User
  end

  it "should allow to connect to information system for supervisors" do
    @library.connect(2, "Dovidauskas").should be_instance_of Supervisor
  end

  it "should allow to connect to information system for admins" do
    @library.connect(3, "Kasperas").should be_instance_of Administrator
  end

  it "should not allow to connect for unregistered users" do
    lambda {
        @library.connect(6, "Kazkoks")
    }.should raise_error "Wrong username or password, please try again"
  end

  it "should not allow to connect if wrong password specified" do
    lambda {
        @library.connect(0, "biel")
    }.should raise_error "Wrong username or password, please try again"
  end

end


