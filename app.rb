require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'user_data'
require_relative 'helpers_methods'

class App
  attr_accessor :books, :people, :rentals

  include UserData

  include SaveData
  include LoadData

  def initialize
    @books = load_books
    @people = load_people
    @rentals = load_rentals
  end

  def list_books
    load_books
    if @books.empty?
      puts
      puts 'No books found'
    else
      @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    end
  end

  def list_people
    if @people.empty?
      puts
      puts 'No people found'
    else
      @people.each_with_index do |person, index|
        puts "#{index}) [#{person.class}] Age: #{person.age}, Name: #{person.name}, ID: #{person.id}"
      end
    end
  end

  def list_rentals
    if @rentals.empty?
      puts 'No rental mode'
    else
      person_id = rental_id
      person_rentals = @rentals.select { |rental| rental.person.id == person_id }
      if person_rentals.empty?
        puts 'Person ID not found'
      else
        person_rentals.each do |list|
          puts "Date: #{list.date}, Books: #{list.book.title} written by Author: #{list.book.author}"
        end
      end
    end
  end

  def create_student
    data = students_info
    @people << if data[2] == 'N'
                 Student.new(data[0], classroom: nil, name: data[1], parent_permission: false)
               else
                 Student.new(data[0], classroom: nil, name: data[1], parent_permission: true)
               end
    puts 'Student created successfully'
    save_people
  end

  def create_teacher
    data = teacher_info
    @people << Teacher.new(data[0], data[2], name: data[1])
    puts 'Teacher created successfully'
    save_people
  end

  def create_book
    data = book_info
    @books << Book.new(data[0], data[1])
    puts 'Book created succesfully'
    save_books
  end

  def create_person
    print 'Do you want to create (1) a student or (2) a teacher? [Input the number]: '
    num_input = gets.chomp.to_i
    person_option(num_input)
  end

  def person_option(num_input)
    case num_input
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid Entry'
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    list_books
    selected_book = book_rental_info
    @books[selected_book]

    puts 'Select a person from the following list by number'
    list_people
    selected_person = person_rental_info
    @people[selected_person]
    date = date_rental_info

    @rentals << Rental.new(date, @people[selected_person], @books[selected_book])
    puts 'Rental created successfully'

    @rentals << Rental.new(date, @books[selected_book], @people[selected_person])
    save_rentals(@rentals)
    puts
    puts 'Rental created successfully'
  end
end
