#----------------------------------------------------------------
#                        GEOMETRY  MODULE                                                       
#----------------------------------------------------------------
# Gives basic operations for : Points, Vectors, Lines and Circles                           
module Geometry
    #------------------  INITIALISATION  ------------------------
    $angle_between_coordinates_system = -Math::PI #Y axis downward
    $round_by_default = true #if set to true, all functions will give a round result by default
    #------------------------------------------------------------

    #------------------  SOLVE  POLY  2  ------------------------
    # Solve second degre polynomial equation
    def solve_poly_2(a, b, c)
        delta = b**2 - 4*a*c

        if (delta < 0) #no solution
            nil

        elsif (delta == 0) #one solution
            [(- b) / (2*a.to_f)]

        elsif( delta > 0) #two solutions
            delta2 = Math.sqrt(delta)
            [
                (-b-delta2)/(2*a.to_f),
                (-b+delta2)/(2*a.to_f)
            ]
        end
    end
    #------------------------------------------------------------


    #---------------------  POINT  ------------------------------
    # Point in a 2D plan
    class Point
        attr_reader :x
        attr_reader :y

        def initialize(x, y)
            @x, @y = x, y 
        end

        def inspect
            return "(x : #{@x}, y : #{@y})"
        end

        def ==(point2)
            self.x == point2.x and self.y == point2.y
        end

        def !=(point2)
            not self == point2
        end

        def +(vector, options = {:round => $round_by_default})
            if options[:round] == true
                Point.new( (self.x+vector.dx).round, (self.y+vector.dy).round )
            else
                Point.new(self.x+vector.dx, self.y+vector.dy)
            end
        end

        def -(vector, options = {:round => $round_by_default})
            if options[:round] == true
                Point.new( (self.x-vector.dx).round, (self.y-vector.dy).round )
            else
                Point.new(self.x-vector.dx, self.y-vector.dy)
            end
        end

        def dist(point2)
            Math.sqrt((point2.x-self.x)**2 + (point2.y-self.y)**2)
        end

        # operates a clockwise rotation
        def rotate(center, rot_angle_deg, options = {:round => $round_by_default})# rotation angle expected in degrees
            if center.is_a?(Array)
                center = Point.new(center[0], center[1])
            end
            old_x, old_y = self.x, self.y
            cent_x, cent_y = center.x, center.y

            # translation to origin
            tmp_x = old_x - cent_x
            tmp_y = old_y - cent_y

            # calculates cosinus and sinus for rotation
            rot_angle_rad = rot_angle_deg * Math::PI / 180
            cos = Math.cos(rot_angle_rad)
            sin = Math.sin(rot_angle_rad)

            # rotation and translation back to previous position
            new_x = tmp_x*cos - tmp_y*sin + cent_x
            new_y = tmp_x*sin + tmp_y*cos + cent_y

            if options[:round] == true
                Point.new(new_x.round, new_y.round)
            else
                Point.new(new_x, new_y)
            end
        end
    end
    #------------------------------------------------------------

    #-----------------------  VECTOR  ---------------------------
    # 2D vector in the plan
    class Vector
        attr_reader :dx
        attr_reader :dy
        attr_reader :length

        def initialize(first, last)
            #Vector.new(Point1, Point2)
            if ( first.is_a?(Point) and last.is_a?(Point) )
                x1, y1 = first.x, first.y
                x2, y2 = last.x, last.y 
                @dx = x2 - x1; @dy = y2 - y1

            #Vector.new([x1, y1], [x2, y2])
            elsif ( first.is_a?(Array) and last.is_a?(Array) )
                x1, y1 = first[0], first[1]
                x2, y2 = last[0], last[1]
                @dx = x2 - x1; @dy = y2 - y1

                #Vector.new(dx, dy)
            elsif ( first.is_a?(Numeric) and last.is_a?(Numeric) )
                @dx = first; @dy = last
            end
            @length = Math.sqrt(@dx**2 + @dy**2 )
        end

        def inspect
            return "<dx : #{@dx}, dy : #{@dy}>"
        end

        def ==(vector2)
            self.dx == vector2.dx and self.dy == vector2.dy
        end

        def !=(vector2)
            not self==vector2
        end

        def +(vector2)
            Vector.new(self.dx+vector2.dx, self.dy+vector2.dy)
        end

        def -(vector2)
            Vector.new(self.dx-vector2.dx, self.dy-vector2.dy)
        end

        def *(number)
            Vector.new(self.dx*number, self.dy*number)
        end

        def angle_rad(vector2)
            angle1 = Math.atan2(self.dx, self.dy)
            angle2 = Math.atan2(vector2.dx, vector2.dy)
            angle = angle2 - angle1 + $angle_between_coordinates_system

            # limits angle between [-PI, PI]
            angle += 2*Math::PI until ( angle > -Math::PI )
            angle -= 2*Math::PI until ( angle <= Math::PI )

            return angle
        end

        def angle_deg(vector2)
            self.angle_rad(vector2) * 180 / Math::PI
        end

        def scalar(vector2)
            angle1 = Math.atan2(self.dx, self.dy)
            angle2 = Math.atan2(vector2.dx, vector2.dy)
            angle = angle2 - angle1

            # limits angle between [-PI, PI]
            angle += 2*Math::PI until ( angle > -Math::PI )
            angle -= 2*Math::PI until ( angle <= Math::PI )

            self.length * vector2.length * Math.cos(angle)
        end
    end


    #------------------------------------------------------------

    #-----------------------  LINE  -----------------------------
    # 2D line in the plan
    class Line
        attr_reader :first
        attr_reader :last
        attr_reader :slope
        attr_reader :ord_or
        attr_reader :eq
        attr_reader :is_vertical
        attr_reader :x_vertical


        def initialize(arg1, arg2)
            # Line.new( [x1, y1], [x2, y2])
            if (arg1.is_a?(Array) and arg2.is_a?(Array))
                @first = Point.new(arg1[0], arg1[1])
                @last  = Point.new(arg2[0], arg2[1])
            # Line.new( Point1, Point2 )
        elsif (arg1.is_a?(Point) and arg2.is_a?(Point)) 
            @first = arg1
            @last  = arg2
            # Line.new( Point1, Vector1 )
        elsif ( arg1.is_a?(Point) and arg2.is_a?(Vector))
            @first = arg1 
            v = arg2
            @last = Point.new( @first.x + v.dx, @first.y + v.dy )
        end
        x1, y1 = @first.x, @first.y
        x2, y2 = @last.x, @last.y

        @is_vertical = false
        @x_vertical = nil

            if (x1 == x2) #vertical
                @slope = Float::INFINITY
                @ord_or = nil   

                @is_vertical = true
                @x_vertical = x1
            elsif (y1 == y2) #horizontal
                @slope = 0
                @ord_or = y1
            else
                @slope = (y2-y1).to_f / (x2-x1).to_f
                @ord_or = y1 - @slope*x1
            end

        end

        def eq
            [@slope, @ord_or]
        end

        def ==(line2)
            self.slope == line2.slope and self.ord_or == line2.ord_or
        end

        def !=(line2)
            not self == line2
        end

        def parallel?(line2)
            self.slope == line2.slope
        end

        def perpendicular?(line2)
            self.x*line2.y == self.y*line2.x
        end

        def intersect?(object)
            if object.is_a?(Circle)
                answer = self.intersect_circle?(object)
            end
        end

        def intersect_circle?(circle, options = {:round => $round_by_default})
            a, b, r = circle.center.x, circle.center.y, circle.radius

            if self.is_vertical
                x = self.x_vertical
                y_list = solve_poly_2(
                    1,
                    -2*b,
                    (x-a)**2 - r**2 + b**2
                    )
                if options[:round]
                    y_list == nil ? false : y_list.map{|y| [x.round, y.round]}
                else
                    y_list == nil ? false : y_list.map{|y| [x, y]}
                end
            else
                d, e = self.slope, self.ord_or  

                x_list = solve_poly_2(
                    1 + d**2,
                    -2*a + 2*d*e - 2*d*b,
                    a**2 + e**2 + b**2 - 2*e*b - r**2
                    )
                if options[:round]
                    x_list == nil ? false : x_list.map{|x| [x.round, (d*x+e).round]}
                else
                    x_list == nil ? false : x_list.map{|x| [x, d*x+e]}
                end
            end
        end
    end
    #------------------------------------------------------------

    #------------------------  CIRCLE  --------------------------
    # Circle in the plan
    class Circle
        attr_reader :center
        attr_reader :radius
        attr_reader :diameter

        def initialize(center, radius)
            if (center.is_a?(Array))
                @center = Point.new(center[0], center[1])
            else
                @center = Point.new(center.x, center.y)
            end

            @radius = radius
            @diameter = 2*radius
        end 
    end
    #------------------------------------------------------------
end
#----------------------------------------------------------------
#----------------------------------------------------------------
