
require './library'
include LIBIS


lib = Library.new

lib.save_sec_data


#lib.books.push(Book.new("Baltoji iltis", "Jack London", "960-425-059-0", 1906, "many knyga"))
#lib.readers.push(Reader.new("Valerij", "Bielskij", Date.new(1990, 04, 29), 0, "Vaidotu 21", "lunacik18@gmail.com"))
#lib.supervisors.push(Supervisor.new("Birute", "Rastenyte", Date.new(1980, 2, 20), 1, "Palangos 15", 987654321))
#lib.admins.push(Admin.new("Audrius", "Paulaskas", Date.new(1997, 9, 19), 2, "Misko 15", 123456789))


lib.save_data
