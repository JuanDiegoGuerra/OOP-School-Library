require_relative 'person'

class Student < Person
  attr_reader :classroom, :json_class, :parent_permission

  def initialize(age, classroom: nil, name: 'Unknown', parent_permission: true, json_class: 'Student')
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    @json_class = json_class
    classroom.students << self unless classroom.nil?
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom.students.delete(self)
    @classroom = classroom
    classroom.students.push(self)
  end
end
