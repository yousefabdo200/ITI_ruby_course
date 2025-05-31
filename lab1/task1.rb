FILENAME = "books.txt"

def list_books
  if File.exist?(FILENAME)
    books = File.readlines(FILENAME).map(&:chomp)
    if books.empty?
      puts "No books in the inventory."
    else
      puts "\nBooks in inventory:"
      books.each do |line|
        title, author, isbn = line.split(',')
        puts "Title: #{title}, Author: #{author}, ISBN: #{isbn}"
      end
    end
  else
    puts "No books file found."
  end
end

def add_book
  print "Enter book title: "
  title = gets.chomp
  print "Enter author name: "
  author = gets.chomp
  print "Enter ISBN: "
  isbn = gets.chomp

  File.open(FILENAME, "a") do |file|
    file.puts "#{title},#{author},#{isbn}"
  end

  puts "Book added successfully!"
end

def remove_book
  print "Enter ISBN of the book to remove: "
  isbn_to_remove = gets.chomp

  if File.exist?(FILENAME)
    lines = File.readlines(FILENAME)
    new_lines = lines.reject { |line| line.include?(isbn_to_remove) }

    if lines.length == new_lines.length
      puts "Book with ISBN #{isbn_to_remove} not found."
    else
      File.open(FILENAME, "w") do |file|
        new_lines.each { |line| file.puts line }
      end
      puts "Book removed successfully!"
    end
  else
    puts "No books to remove."
  end
end

# Main menu loop
loop do
  puts "\nBook Inventory"
  puts "1. List all books"
  puts "2. Add a new book"
  puts "3. Remove a book by ISBN"
  puts "4. Exit"
  print "Choose an option (1-4): "
  choice = gets.chomp

  case choice
  when "1"
    list_books
  when "2"
    add_book
  when "3"
    remove_book
  when "4"
    puts "Goodbye!"
    break
  else
    puts "Invalid option. Please choose 1-4."
  end
end
