require_relative 'module_Geometry.rb'
include Geometry

#------- CREATION OF VECTORS ----------
# first arg is x and second arg is y
abs_v = Vector.new(10, 0) 
ord_v = Vector.new(0, 10)
puts "You have created vectors abs_v : #{abs_v.inspect} and ord_v #{ord_v.inspect}"
puts

#------- CREATION OF POINTS ----------
# normal constructor
point_1 = Point.new(5, 6)
point_2 = Point.new(5, 7)
puts "You have created points point_1 : #{point_1.inspect} and point_2 #{point_2.inspect}"
puts

# modifier :
# it is possible to create a new point by simply adding a vector to it
plop = Point.new(5,6)
plop+Vector.new(7, 3)

#------------ ROTATION --------------
center = Point.new(0, 0)
point_to_rotate = Point.new(-3, 2)
b = point_to_rotate.rotate(center, 180) # the rotation of center "center" and angle 180 degres is applied to point "point_to_rotate"

#------- CREATION OF LINES ----------

# First construcotor :  by giving arrays of coords
abs = Line.new([0,1],[0,2])
ord = Line.new([1,0],[2,0])

# Second construcor : by explicitly giving two points
l2 = Line.new( Point.new(-2, 3), Point.new(10,28) )

# Third constructor : by giving a point and a vector
point_3 = Point.new(5, 6)
l3 = Line.new(point_3, Vector.new(0, 10))

my_line = Line.new([4,3], [4,8])
puts "A new line has the following arguments : "
p my_line
puts

#------- ANGLE CALCULATION ----------
init = Point.new(0, 0)
a = Point.new(-3, 2)
value1 = Vector.new(init, a).angle_deg(abs_v)
value2 = Vector.new(init, b).angle_deg(abs_v)
puts "Example of an angle calculus : #{value1} degres"

#------- CREATION OF CIRCLES ----------

# Constructor : by giving a center and a radius
c = Circle.new([-2,0], 4) 
puts "You have created this following circle : #{c.inspect}"
puts

#------- MORE ADVANCED EXAMPLES ----------

# intersection
c2 = Circle.new([-2,3], 4)
l2 = Line.new( Point.new(-2, 3), Point.new(10,28) )
puts "Circle c2 intersects Line l2 at these coordinates #{l2.intersect?(c2).inspect }"
puts


# grow a circle until it touches a line
l2 = Line.new([-5,8.5], [1.0,-4])
r = 0
result = 0
until result.is_a?(Array)	
	r += 1
	c2 = Circle.new([-2,3], r)
	points = l2.intersect?(c2)
	result = points != false ? points.map{|a| Point.new(a[0],a[1])} : 0
end

puts "The points of intersection of the growing circle are : #{points.inspect}"
