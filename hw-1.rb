require 'date'

class Student
  attr_reader :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth
    validate_date_of_birth
    add_student
  end

  def validate_date_of_birth
    raise ArgumentError, "Date of birth must be in the past" if @date_of_birth > Date.today
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth + age.years
    age
  end

  def add_student
    unless @@students.any? { |student| student.name == @name && student.date_of_birth == @date_of_birth }
      @@students << self
    else
      raise ArgumentError, "Student with such name and date of birth already exists."
    end
  end

  def self.remove_student(name, date_of_birth)
    @@students.delete_if { |student| student.name == name && student.date_of_birth == date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end
end


begin
  student_first = Student.new("Jana", "Krukova", Date.new(2005, 10, 15))
  student_second = Student.new("Jana", "Krukova", Date.new(2005, 10, 15))
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

begin
  future_student = Student.new("Andriy", "Onopko", Date.today + 365)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end
