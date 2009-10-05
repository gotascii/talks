require 'rinda/ring'
Point = Struct.new 'Point', :x, :y
Point.send(:include, DRbUndumped)

DRb.start_service
ring_server = Rinda::RingFinger.primary
distance_calculator = ring_server.read([:app_1, :distance_calculator, nil, nil])[2]

p1 = Point.new 2, 5
p2 = Point.new 1, 45

puts "The distance is #{distance_calculator.calculate p1, p2}"