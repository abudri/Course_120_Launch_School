=begin 
Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

puts "Well done!" if joe.better_grade_than?(bob)
=end 

class Student

  def initialize(n, g)
    @name = n
    @grade = g
  end 

  def better_grade_than?(other_student)
    grade > other_student.grade
  end 

  protected 

  def grade 
    @grade
  end 

end 

=begin
some output here of the above:

irb(main):019:0> joe = Student.new("Joe", 97)
=> #<Student:0x00007f8217976a30 @name="Joe", @grade=97>
irb(main):020:0> bob = Student.new("Bob", 94)
=> #<Student:0x00007f821796dcf0 @name="Bob", @grade=94>
irb(main):021:0> joe.better_grade_than?(bob)
=> true
irb(main):022:0> puts "Well done!" if joe.better_grade_than?(bob)
Well done!
=> nil

=end 

