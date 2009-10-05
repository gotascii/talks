require 'drb'

uri = 'druby://localhost:54088'

remote_array = DRbObject.new nil, uri

puts remote_array.size
remote_array << 1
puts remote_array.size