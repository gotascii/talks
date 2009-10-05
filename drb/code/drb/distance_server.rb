require 'drb'

class DistanceCalculator
  def calculate(p1, p2)
    Math.sqrt((p1.x - p2.x)**2 + (p1.y - p2.y)**2)
  end
end

DRb.start_service nil, DistanceCalculator.new
puts DRb.uri
DRb.thread.join