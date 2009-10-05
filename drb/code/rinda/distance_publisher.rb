require 'rinda/ring'

class DistanceCalculator
  include DRbUndumped

  def calculate(p1, p2)
    Math.sqrt((p1.x - p2.x)**2 + (p1.y - p2.y)**2)
  end
end

DRb.start_service
ring_server = Rinda::RingFinger.primary
ring_server.write([:app_1,
  :distance_calculator,
  DistanceCalculator.new,
  'A simple distance calculator.'],
  Rinda::SimpleRenewer.new)

DRb.thread.join