require_relative 'rental'

class Book

  attr_accessor :title, :author, :rentals, :id

  def initialize(title, author, id: Random.rand(1..100))
    @id = id
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, person, self)
  end
end
