require 'drb'

Point = Struct.new 'Point', :x, :y
Point.send(:include, DRbUndumped)

DRb.start_service
distance_calculator = DRbObject.new nil, 'druby://localhost:54107'

p1 = Point.new 0, 0
p2 = Point.new 1, 0

puts "The distance is #{distance_calculator.calculate p1, p2}"