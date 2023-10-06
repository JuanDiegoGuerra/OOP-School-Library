require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    puts 'Welcome to School Library App!'
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, AGE: #{person.age}"
    end
  end

  def list_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      unless rental.person.id != person_id
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp.to_i
    case person_type
    when 1
      print 'Age: '
      person_age = gets.chomp.to_i
      print 'Name: '
      person_name = gets.chomp.to_s
      print 'Has parent permission? [Y/N]: '
      person_permission = gets.chomp.to_s.capitalize
      @people << if person_permission == 'N'
                   Student.new(person_age, classroom: nil, name: person_name, parent_permission: false)
                 else
                   Student.new(person_age, classroom: nil, name: person_name, parent_permission: true)
                 end
      puts 'Student created successfully'
    when 2
      print 'Age: '
      person_age = gets.chomp.to_i
      print 'Name: '
      person_name = gets.chomp.to_s.capitalize
      print 'Specialization: '
      person_specialization = gets.chomp.to_s.capitalize
      @people << Teacher.new(person_specialization, person_age, name: person_name)
      puts 'Teacher created successfully'
    else
      puts 'Error: Enter a valid number'
      create_person
    end
  end

  def create_book
    print 'Title: '
    book_title = gets.chomp.to_s.capitalize
    print 'Author: '
    book_author = gets.chomp.to_s.capitalize
    @books << Book.new(book_title, book_author)
    puts 'Book created succesfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    puts ''
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, AGE: #{person.age}"
    end
    person_index = gets.chomp.to_i
    puts ''
    print 'Date: '
    rent_date = gets.chomp.to_s
    @rentals << Rental.new(rent_date, @people[person_index], @books[book_index])
    puts 'Rental created successfully'
  end
end
