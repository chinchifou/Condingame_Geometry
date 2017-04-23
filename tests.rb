require 'minitest/autorun'
require_relative 'module_Geometry.rb'
include Geometry

class TestGeometry < Minitest::Test


# GENERAL TEST PATTERN

	# test individual constructor
		# normal value
		# unexpected value
		# impossible value

	# test individiual modifiers

	# test interactions

	def test_solve_poly
		assert_equal( [1/3.0, 1/2.0], solve_poly_2(36,-30,6) )
		refute_equal( [5, 8], solve_poly_2(36,-30,6) )
	end

	def test_point
		point_1 = Point.new(2,3)
			assert_equal(2, point_1.x)
			assert_equal(3, point_1.y)
			assert_equal("(x : 2, y : 3)", point_1.inspect)

		point_2 = Point.new(-2,1.5)
			assert_equal(-2, point_2.x)
			assert_equal(1.5, point_2.y)
			assert_equal("(x : -2, y : 1.5)", point_2.inspect)

		#TO DO impossible values


		refute_equal(point_1, point_2)
		assert_equal(Math.sqrt( (2+2)*(2+2) + (3-1.5)*(3-1.5) ), point_1.dist(point_2) )

		point_3 = Point.new(2.0, 3.000)
		assert_equal(point_1, point_3)


		point_0 = Point.new(0,0)

		point_4 = point_1.rotate(point_0,-90)
		assert_equal(point_4, Point.new(3,-2))

		point_5 = point_1.rotate(point_0,-180)
		assert_equal(point_5, Point.new(-2,-3))	
	end

	def test_vector
	end

	def test_line
	end

	def test_circle
	end

end