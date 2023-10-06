require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom: nil, name: 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
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
