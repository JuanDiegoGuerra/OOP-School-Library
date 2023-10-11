require 'json'
require 'fileutils'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

module SaveData
  def check_file(filename)
    FileUtils.mkdir_p('./data_files')
    FileUtils.touch('./data_files/people.json') if !File.exist?('./data_files/people.json') && filename == 'people'
    FileUtils.touch('./data_files/rentals.json') if !File.exist?('./data_files/rentals.json') && filename == 'rentals'
    FileUtils.touch('./data_files/books.json') if !File.exist?('./data_files/books.json') && filename == 'books'
  end

  def save_books
    books_data = []
    books.each do |book|
      books_data << { title: book.title, author: book.author }
    end
    return if books_data.empty?

    check_file('books')
    File.write('./data_files/books.json', JSON.pretty_generate(books_data))
  end

  def save_people
    people_data = []
    people.each do |person|
      person_prop = { id: person.id, age: person.age, name: person.name, json_class: person.json_class }
      if person.json_class == 'Student'
        person_prop[:classroom] = person.classroom
        person_prop[:parent_permission] = person.parent_permission
      else
        person_prop[:specialization] = person.specialization
      end

      people_data << person_prop
    end
    return if people_data.empty?

    check_file('people')
    File.write('./data_files/people.json', JSON.pretty_generate(people_data))
  end

  def save_rentals(rentals)
    rental_arr = []
    rentals.each do |rental|
      rental_prop = {
        date: rental.date,
        title: rental.book.title, author: rental.book.author,
        id: rental.person.id, name: rental.person.name, age: rental.person.age,
        type: rental.person.json_class
      }
      if rental.person.json_class == 'Student'
        rental_prop[:classroom] = rental.person.classroom
      else
        rental_prop[:specialization] = rental.person.specialization
      end
      rental_arr << rental_prop
    end
    return if rental_arr.empty?

    check_file('rentals')
    File.write('./data_files/rentals.json', JSON.pretty_generate(rental_arr))
  end
end

module LoadData
  def load_books
    books = []
    if File.exist?('./data_files/books.json')
      data = File.read('./data_files/books.json')
      if data != ''
        JSON.parse(data).map do |book|
          books.push(Book.new(book['title'], book['author']))
        end
      end
    end
    books
  end

  def load_people
    people = []
    if File.exist?('./data_files/people.json')
      data = File.read('./data_files/people.json')
      if data != ''
        JSON.parse(data).map do |person|
          if person['json_class'] == 'Student'
            student = Student.new(person['age'], classroom: person['classroom'], name: person['name'],
                                                 parent_permission: person['parent_permission'])
            student.id = person['id']
            people << student
          else
            teacher = Teacher.new(person['age'], person['specialization'], name: person['name'],
                                                                           parent_permission: person['parent_permission'])
            teacher.id = person['id']
            people << teacher
          end
        end
      end
    end
    people
  end

  def load_rentals
    rentals = []
    return rentals unless File.exist?('./data_files/rentals.json')

    file = File.open('./data_files/rentals.json')
    rental_data = JSON.parse(file.read)
    rental_data.each do |rental|
      if rental['json_class'] == 'Teacher'
        teacher = Teacher.new(rental['age'], rental['specialization'], name: rental['name'],
                                                                       parent_permission: rental['parent_permission'])
        teacher.id = rental['id']
        book = Book.new(rental['title'], rental['author'])
        new_rental = Rental.new(rental['date'], book, teacher)
      else
        student = Student.new(rental['age'], classroom: rental['classroom'], name: rental['name'],
                                             parent_permission: rental['parent_permission'])
        student.id = rental['id']
        book = Book.new(rental['title'], rental['author'])
        new_rental = Rental.new(rental['date'], book, student)
      end
      rentals << new_rental
    end
    file.close
    rentals
  end

  def get_person(id)
    @people.find { |person| person.id == id }
  end

  def get_book(id)
    @books.find { |book| book.id == id }
  end
end