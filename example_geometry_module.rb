require_relative 'module_Geometry.rb'
include Geometry

#____creation of vectors_____
#first arg is x and second arg is y
abs_v = Vector.new(10, 0) 
ord_v = Vector.new(0, 10)

#___creation of Points______
# A/ normal construcor
point_1 = Point.new(5, 6)
point_2 = Point.new(5, 7)

# modifier : override of operator + to modify a point based on a given vector
plop = Point.new(5,6)
plop+Vector.new(7, 3)

#_______rotation________
center = Point.new(0, 0)
point_to_rotate = Point.new(-3, 2)
b = point_to_rotate.rotate(center, 180) # the rotation of center "center" and angle 180 degres is applied to point "point_to_rotate"

#____creation of lines______

# A/ by giving arrays of coords
abs = Line.new([0,1],[0,2])
ord = Line.new([1,0],[2,0])

# B/ by explicitly giving two points
l2 = Line.new( Point.new(-2, 3), Point.new(10,28) )

# C/ by giving a point and a vector
point_3 = Point.new(5, 6)
l3 = Line.new(point_3, Vector.new(0, 10))

my_line = Line.new([4,3], [4,8])
puts "A new line as the following arguments : "
p my_line
puts


#_____angle calculation________
init = Point.new(0, 0)
a = Point.new(-3, 2)
value1 = Vector.new(init, a).angle_deg(abs_v)
value2 = Vector.new(init, b).angle_deg(abs_v)

#______creation of circles______
# by giving a center and a radius
c= Circle.new([-2,0], 4) 

# advanced examples : 

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

puts "The points of intersection of the growing circle are : #{result.inspect}"
