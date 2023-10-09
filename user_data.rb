module UserData
    def students_info
      print 'Age: '
      person_age = gets.chomp.to_i
      print 'Name: '
      person_name = gets.chomp.to_s
      print 'Has parent permission? [Y/N]: '
      person_permission = gets.chomp.to_s.capitalize
      [person_age, person_name, person_permission]
    end
  
    def teacher_info
      print 'Age: '
      person_age = gets.chomp.to_i
      print 'Name: '
      person_name = gets.chomp.to_s.capitalize
      print 'Specialization: '
      person_specialization = gets.chomp.to_s.capitalize
      [person_age, person_name, person_specialization]
    end
  
    def rental_id
      print 'ID of person: '
      gets.chomp.to_i
    end
  
    def book_info
      print 'Title: '
      book_title = gets.chomp.to_s.capitalize
      print 'Author: '
      book_author = gets.chomp.to_s.capitalize
      [book_title, book_author]
    end
  
    def book_rental_info
      gets.chomp.to_i
    end
  
    def person_rental_info
      gets.chomp.to_i
    end
  
    def date_rental_info
      print 'Date (DD/MM/YYYY): '
      gets.chomp
    end
  end
Collapse
