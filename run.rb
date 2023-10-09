require_relative 'app'
require_relative 'user_data'

class Run
  include UserData

  def initialize
    @app = App.new
  end

  def show_options
    puts ''
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def entry_point
    puts 'Welcome to School Library App!'

    loop do
      show_options
      app_choice = gets.chomp.to_i
      options(app_choice)
    end
  end

  def options(input)
    case input
    when 1
      @app.list_books
    when 2
      @app.list_people
    when 3
      print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
      person_type = gets.chomp.to_i
      case person_type
      when 1
        @app.create_student
      when 2
        @app.create_teacher
      else
        puts 'Error: Enter a valid number'
      end
    when 4
      @app.create_book
    when 5
      @app.create_rental
    when 6
      @app.list_rentals
    when 7
      puts 'Thanks for using the school library App!'
      puts 'Created by JD & Hafiz'
      exit
    else
      puts 'Invalid Entry'
    end
  end
end
